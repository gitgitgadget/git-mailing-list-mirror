From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: git merge --date --author
Date: Fri, 07 Mar 2014 12:41:01 +0100
Message-ID: <5319B04D.6080906@alum.mit.edu>
References: <1394188215.3257.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Yann Droneaud <ydroneaud@opteya.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 12:41:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLt9V-00034o-0g
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 12:41:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818AbaCGLlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2014 06:41:08 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:56428 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752116AbaCGLlF (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Mar 2014 06:41:05 -0500
X-AuditID: 1207440c-f79656d000003eba-c3-5319b05064cd
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id BF.50.16058.050B9135; Fri,  7 Mar 2014 06:41:04 -0500 (EST)
Received: from [192.168.69.148] (p4FDD4FF5.dip0.t-ipconnect.de [79.221.79.245])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s27Bf2v5004821
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 7 Mar 2014 06:41:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <1394188215.3257.17.camel@localhost.localdomain>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsUixO6iqBuwQTLYYOpjCYuuK91MFk37V7E7
	MHlcX32fzePzJrkApihum6TEkrLgzPQ8fbsE7oxnv+4wF2zgqlgxrY+tgXE6RxcjJ4eEgInE
	xJmLmCFsMYkL99azdTFycQgJXGaU2DPhGTtIQkjgHJPEp/2mIDavgLbEzV1LWEBsFgFVidXn
	/oHZbAK6Eot6mplAbFGBYInVlx+wQNQLSpyc+QTI5uAQEdCQmLVEEcRkFhCX6IfoFBZQk9h/
	5CozSFhIwEbi5l9DkDCngK3EyaVT2EDCEkDVPY1BEI3qEuvnCYFUMAvIS2x/O4d5AqPgLCSb
	ZiFUzUJStYCReRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrqFebmaJXmpK6SZGSNDy7GD8tk7m
	EKMAB6MSD2/HIolgIdbEsuLK3EOMkhxMSqK8kWslg4X4kvJTKjMSizPii0pzUosPMUpwMCuJ
	8PKsBsrxpiRWVqUW5cOkpDlYlMR5VZeo+wkJpCeWpGanphakFsFkZTg4lCR4b4MMFSxKTU+t
	SMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAdFbXwxMG5BUjxAe5PWg+wtLkjMBYpCtJ5i1OW4
	3fbrE6MQS15+XqqUOK8SSJEASFFGaR7cCliKesUoDvSxMK8VSBUPML3BTXoFtIQJaIlFINiS
	kkSElFQDI/PlKo71P2bzXXT50p0ZeMYr2cOJMywqoibS41Akf7Bn55pzCyqXKcxTOHr/4SuH
	B5pLlO14hA68OzpnbtGBS28f2XMYLE9p3vIhb8n3i1P7jr0K09/jrKa0oiM56nvZ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243611>

On 03/07/2014 11:30 AM, Yann Droneaud wrote:
> I was trying to rebuild some history and found myself trying to use some
> options with git merge which are available in git commit:
> 
>  git merge \
>      --date "2013-12-31 23:59:59 +0000" \
>      --author "Happy New Year <happy.new-year@gregorian.calendar>" \
>      current-year
> 
> But unfortunately, unlike git commit, git merge doesn't support either
> --date or --author.
> 
> I can work around with environment variables:
> 
>  GIT_AUTHOR_DATE="2013-12-31 23:59:59 +0000" \
>  GIT_AUTHOR_NAME="Happy New Year" \
>  GIT_AUTHOR_EMAIL="happy.new-year@gregorian.calendar"  \
>  git merge current-year

You can also use

    git merge --no-commit [...]
    git commit --date ... --author ...

> But I'd like to know if there's a specific reason for git merge to not
> support --date and --author ?

None that I can think of, except that nobody has implemented it.  Don't
forget that the merge invocation might not lead immediately to a commit
(if there is a conflict, or if --no-commit is used) so the metadata that
is passed to its command line would have to be tucked away safely
somewhere until the merge commit is finally ready to be created.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/

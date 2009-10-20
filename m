From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: git gc and kernel.org
Date: Tue, 20 Oct 2009 16:51:06 +0900
Message-ID: <4ADD6BEA.3080300@zytor.com>
References: <4ADD6026.8070203@zytor.com> <7veioyqzeo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, ftpadmin@kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 09:52:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N09W1-0005as-5a
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 09:52:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbZJTHwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 03:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbZJTHwK
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 03:52:10 -0400
Received: from terminus.zytor.com ([198.137.202.10]:46055 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117AbZJTHwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 03:52:09 -0400
Received: from [192.168.11.49] (p32183-ipbffx02marunouchi.tokyo.ocn.ne.jp [220.106.13.183])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.3/8.14.3) with ESMTP id n9K7pBw6030110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Tue, 20 Oct 2009 00:51:13 -0700
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.4pre) Gecko/20091014 Fedora/3.0-2.8.b4.fc11 Thunderbird/3.0b4
In-Reply-To: <7veioyqzeo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130772>

On 10/20/2009 04:48 PM, Junio C Hamano wrote:
> As to (1), I think it is reasonable to do some sort of "gc" in
> receive-pack, and while I recall that Linus was violently against the
> idea, I personally think it is reasonable to run update-server-info
> ourselves at the same time without needing the hook, even if the
> repository is never going to be served over dumb http [*1*].  At one
> point, update-server-info used to compute a lot more than what we
> currently compute and it made some sense to oppose against it on
> performance ground.
>
> But these days it only lists the refs and packs and does nothing else; the
> performance impact should be immeasurable and it adds only two files to
> the repository.  It cannot be a big deal, unless you oppose to http
> transport on a non-technical ground.

I'm obviously happy with making it a non-default option; we can enable 
it sitewide on kernel.org.

However, git update-server-info seems to take almost no time even in 
very large repos.

	-hpa

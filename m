From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: cvs2git migration
Date: Tue, 14 Feb 2012 21:17:18 +0100
Message-ID: <4F3AC14E.9040306@ira.uka.de>
References: <1329220866066-7283631.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: supadhyay <supadhyay@imany.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 21:16:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxOnm-0000t0-NC
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 21:16:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757152Ab2BNUQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 15:16:34 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:42318 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755460Ab2BNUQe (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2012 15:16:34 -0500
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1RxOnR-0002C3-R9; Tue, 14 Feb 2012 21:16:32 +0100
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 25 
	id 1RxOnR-0001Pk-NY; Tue, 14 Feb 2012 21:16:17 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <1329220866066-7283631.post@n2.nabble.com>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1329250592.924002000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190747>

On 14.02.2012 13:01, supadhyay wrote:
> Hi All,
>
> I want to migrate my version control CVS to GIT. I have few links which
> mentioned about how to migrate CVS repositories to GIT but there is no
> description about how to migrate existing CVS users to GIT?

As far as I know CVS uses its own server called pserver. And the usual 
username and password combo for authentication.

if you want to use git with a central repository, you should use 
gitolite. And gitolite uses RSA or DSA keys that are not compatible with 
CVS passwords. You can't simply migrate the users to gitolite.

Every user has to generate and send the public half of that key 
(generated with ssh-keygen) to the administrator of that repository.

If you have problems authenticating all those users sending you public 
keys, let them check in the public keys into a specific path in one of 
the old CVS repositories. Then the administrator of the git repository 
can fetch them from the CVS (and check that the right user added the 
patch for his new key).

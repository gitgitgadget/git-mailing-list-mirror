From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v3] git-p4: add "--path-encoding" option
Date: Tue, 1 Sep 2015 06:37:59 +0200
Message-ID: <55E52BA7.6020303@web.de>
References: <1441059026-66814-1-git-send-email-larsxschneider@gmail.com>
 <1441059026-66814-2-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: luke@diamand.org, gitster@pobox.com
To: larsxschneider@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 01 06:38:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWdKs-0000Ht-CA
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 06:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752804AbbIAEiP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 00:38:15 -0400
Received: from mout.web.de ([212.227.17.11]:63470 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751505AbbIAEiO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 00:38:14 -0400
Received: from [192.168.88.190] ([194.47.243.242]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0LdW7q-1YpHp70ary-00ihXD; Tue, 01 Sep 2015 06:38:07
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.2.0
In-Reply-To: <1441059026-66814-2-git-send-email-larsxschneider@gmail.com>
X-Provags-ID: V03:K0:3xQOoNiYw54+JgX24PPrqL+PqqedC8quIrkLeVpY4GY/SxfRPPQ
 Y58+HPqLfEKczSkhFWxu/zciTRHdlfxd9AOC3GoeYtoZe26K8CGLy/6zfLeAPGG2XRmM12N
 krneAbCmTUV/f12wbej2YPts7gQWaDcYXxtGw+JEKTTbTGSNH8HaEBwPqTlbPzF8XweDEvC
 o4J6M+hci7Yv3kK5FX1gA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nLdCktRrjwQ=:hA45zv8X4q8ztrn/TY5/2f
 rRezeTktNsEnh2OeWVyCg8Pvr0AZ+0BbeGagNIljLSOOX1a1T+kFCd50w6gnp6cpPto4HyGBw
 k7jKyePnCvDd2ekSlr+pyvWLW/lH0kQlkKR7h3ahejcb6EuF1MvN89F0pNfwpXTN3eBp9Odq1
 gZVfI60Fy19lmGRkYnkzyW7peF7rKOS+FFF2AwsfAGUr+MFjiNbHvnGazzuPi3wSvm1QPAqaY
 SiXIiQJVpRqs48M1KHOTvHYtQR08y7ZyiNktYK+PmQJXJHT2Z/nS7Y55JHIbdKW2Za2W0OOZx
 4GvxRqrKWpCMEkWbKCi9b0d4M/cY7UjExt+Hk+Si7nFp/Zn2fhD+ons2v70OcGJnSV1EP9Ltl
 NCGa54mRyM6ytjenCr3qDzG/3Kz2gUHJJwQMV7Z6+6eitL/+rJJkaEcbiOtBo9FoGeVMI1ZZW
 OFdqa3Js9Kaxyg2KNHaymUS+W10DoL9egQOJM0ZT+dLGzdwNsb5Ub5Zx0MaGUnkt/ZkkHBP33
 DAck7pN1g7WaovKlVv+q/JIoR6iLuOiOK8bmbrhyBnf2Usk+1j/Fu+dlRmp/hLEbTOzMkXUNB
 Pa6rqR8mnJaimEXU50y6G69YfwSlVfI7CfkzYn3g8KYdtOds4dhnlZf6u0WeywXM/++wCwvWe
 iH93onZ1tj9C7gjDQ21JUztaIwJlFew2xceN09ueV+5OIJREwOfilAR7xfpKBytavEFcVP6bW
 val1cQOjITqetQqZNTQWr9M6AFUQp7xgjHMdcQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276967>



On 01/09/15 00:10, larsxschneider@gmail.com wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>   Documentation/git-p4.txt        |  5 +++++
>   git-p4.py                       |  6 ++++++
>   t/t9821-git-p4-path-encoding.sh | 38 ++++++++++++++++++++++++++++++++++++++
>   3 files changed, 49 insertions(+)
>   create mode 100755 t/t9821-git-p4-path-encoding.sh
>
> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
> index 82aa5d6..14bb79c 100644
> --- a/Documentation/git-p4.txt
> +++ b/Documentation/git-p4.txt
> @@ -252,6 +252,11 @@ Git repository:
>   	Use a client spec to find the list of interesting files in p4.
>   	See the "CLIENT SPEC" section below.
>   
> +--path-encoding <encoding>::
> +	The encoding to use when reading p4 client paths. With this option
> +	non ASCII paths are properly stored in Git. For example, the encoding
> +	'cp1252' is often used on Windows systems.
> +
>   -/ <path>::
>   	Exclude selected depot paths when cloning or syncing.
>   
> diff --git a/git-p4.py b/git-p4.py
> index 073f87b..2b3bfc4 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1981,6 +1981,8 @@ class P4Sync(Command, P4UserMap):
>                   optparse.make_option("--silent", dest="silent", action="store_true"),
>                   optparse.make_option("--detect-labels", dest="detectLabels", action="store_true"),
>                   optparse.make_option("--import-labels", dest="importLabels", action="store_true"),
> +                optparse.make_option("--path-encoding", dest="pathEncoding", type="string",
> +                                     help="Encoding to use for paths"),
>                   optparse.make_option("--import-local", dest="importIntoRemotes", action="store_false",
>                                        help="Import into refs/heads/ , not refs/remotes"),
>                   optparse.make_option("--max-changes", dest="maxChanges",
> @@ -2025,6 +2027,7 @@ class P4Sync(Command, P4UserMap):
>           self.clientSpecDirs = None
>           self.tempBranches = []
>           self.tempBranchLocation = "git-p4-tmp"
> +        self.pathEncoding = None
>   
>           if gitConfig("git-p4.syncFromOrigin") == "false":
>               self.syncWithOrigin = False
> @@ -2213,6 +2216,9 @@ class P4Sync(Command, P4UserMap):
>               text = regexp.sub(r'$\1$', text)
>               contents = [ text ]
>   
> +        if self.pathEncoding:
> +            relPath = relPath.decode(self.pathEncoding).encode('utf8', 'replace')
> +
>           self.gitStream.write("M %s inline %s\n" % (git_mode, relPath))
>   
>           # total length...
> diff --git a/t/t9821-git-p4-path-encoding.sh b/t/t9821-git-p4-path-encoding.sh
> new file mode 100755
> index 0000000..1626fc5
> --- /dev/null
> +++ b/t/t9821-git-p4-path-encoding.sh
> @@ -0,0 +1,38 @@
> +#!/bin/sh
> +
> +test_description='Clone repositories with non ASCII paths'
> +
> +. ./lib-git-p4.sh
> +
> +UTF8_ESCAPED="a-\303\244_o-\303\266_u-\303\274.txt"
> +
> +test_expect_success 'start p4d' '
> +	start_p4d
> +'
> +
> +test_expect_success 'Create a repo containing iso8859-1 encoded paths' '
> +	cd "$cli" &&
> +
> +	ISO8859="$(printf "$UTF8_ESCAPED" | iconv -f utf-8 -t iso8859-1)" &&
> +	>"$ISO8859" &&
> +	p4 add "$ISO8859" &&
> +	p4 submit -d "test commit"
> +'
Sorry for being persistant,
but you can't create files with names that  are ISO-8859-1 encoded under Mac OS,
we end up like this:

  a-%E4_o-%F6_u-%FC.txt


(And I'm still not convinced, that we need to call iconv each time we execute 
the TC,
for a string that is always the same.
The string can be converted once, and embedded in the TC:
The following should work under Mac OS (but I don't have p4 to test it)

ISO8859_ESCAPED="a-\303\244_o-\303\266_u-\303\274.txt"

UTF8_ESCAPED="\141\055\303\203\302\244\137\157\055\303\203\302\266\137\165\055\303\203\302\274\056\164\170\164"

ISO8859=$(printf "$ISO8859_ESCAPED")

> +
> +test_expect_success 'Clone repo containing iso8859-1 encoded paths' '
> +	git p4 clone --destination="$git" --path-encoding=iso8859-1 //depot &&
> +	test_when_finished cleanup_git &&
> +	(
> +		cd "$git" &&
> +		printf "$UTF8_ESCAPED\n" >expect &&
> +		test_config core.quotepath false &&
> +		git ls-files >actual &&
> +		test_cmp expect actual
> +	)
> +'
>
The ls-files can be written shorter (if we like short code)

+		git -c core.quotepath=false ls-files >actual &&

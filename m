From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2 1/2] git-p4: add test case for "Translation of file
 content failed" error
Date: Tue, 15 Sep 2015 06:40:13 +0200
Message-ID: <55F7A12D.9020603@web.de>
References: <1442249728-89494-1-git-send-email-larsxschneider@gmail.com> <1442249728-89494-2-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, luke@diamand.org
To: larsxschneider@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 06:40:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zbi2v-0003rJ-88
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 06:40:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbbIOEkk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 00:40:40 -0400
Received: from mout.web.de ([212.227.17.11]:56119 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750930AbbIOEkj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 00:40:39 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0Maaur-1ZM6y83ki1-00KBt6; Tue, 15 Sep 2015 06:40:34
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1442249728-89494-2-git-send-email-larsxschneider@gmail.com>
X-Provags-ID: V03:K0:CrRzfNT1v6qf7SiLekg8kzhJ8tzdpNbT6jf9isTsrTtU/oaUf6W
 lR6dD5a9xscSZ9+GpJsSjnvmjjAGDtnGR7Ns4RyrAIvzLkn6sIoFDtCQg4tK3QMXnajfXkh
 1karg+PfcpA5FhJhfsmYWhYSWZv9ZvYTMFxlcl993JXXUJtWifkBs29rRZ58eR67fEKXBzL
 lli5cx9rvVZPs+qcVVMWw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TSJxJaNgAuQ=:bjaGZi6Et9eYhg/nKKTBQO
 kKUDMXtLfOUPi6Y3TFYmP5HuI843bszfQ4LyPc6olSP/aVsdAIWbEmaHh1AU2/g4+9aSXdsMa
 ihqCxU9qLwzYoQHq+quT0wxFe7FGyNCCG2XX4GZv4MPm2ePOA8XegctQ+OGB2jdXFctqxDlZY
 MwGcn8jB0WRTNPCqbigL2miU1zwRN/vsFz0XtGdyk8hJBj3ueGXNzxb2e1MUl16mHVhUDDkHT
 vx6kBzVSFuWZC6SAPEYybJUCK6dStEW7FzP9XSWisSJDpkNlvXJ2KvV/OYXIZ+EOWzzWUz+30
 QoSm0j5IGpkWqRFHdrduvXKNRp2wLqdwmVziapoOUM0B+wlomS1NPTix72H82dDiLRMVcwrQZ
 BQb99B5PfyrfkO8ubTlU9S6NzWyEfGEDTLM4DgE1zItZcDWcwfujHcV7KvGcC4x8S7DmTNA4h
 Djp23jz1pVVysfdAXe2yD2TLP2bNvHoPyCcGazk/yJOxG/urz5EeaBf5wkApgUnyq9ir8ghUL
 eCz55lTmUp4O92c8WqduOXd/KK+Dp0eEQkaIYSP89FBn7OKs7xgsr2qfUNI4MG5zfp2yb81Cl
 93d5atCB0qGNtIl0bTkhJcE5ElAb1bhsnCnwDoPV/OXDLAxDcB2jzhfiFx6qj9bHUjH81Zu5n
 32uX90kpn0Af3F2qnS1Y4v/vxedad8gn98j0wk7IpQuTK1EyuPPM+zKkQEkmFN5IFfWqgH74b
 03rjW3/fiiknY2W6wDF9z+L/kz43CO/NW7f69A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277885>

On 09/14/2015 06:55 PM, larsxschneider@gmail.com wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
>
> A P4 repository can get into a state where it contains a file with
> type UTF-16 that does not contain a valid UTF-16 BOM. If git-p4
> attempts to retrieve the file then the process crashes with a
> "Translation of file content failed" error.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>   t/t9824-git-p4-handle-utf16-without-bom.sh | 47 ++++++++++++++++++++++++++++++
>   1 file changed, 47 insertions(+)
>   create mode 100755 t/t9824-git-p4-handle-utf16-without-bom.sh
>
> diff --git a/t/t9824-git-p4-handle-utf16-without-bom.sh b/t/t9824-git-p4-handle-utf16-without-bom.sh
> new file mode 100755
> index 0000000..fa8043b
> --- /dev/null
> +++ b/t/t9824-git-p4-handle-utf16-without-bom.sh
> @@ -0,0 +1,47 @@
> +#!/bin/sh
> +
> +test_description='git p4 handle UTF-16 without BOM'
> +
> +. ./lib-git-p4.sh
> +
> +UTF16="\\x97\\x0\\x97\\x0"
> +
> +test_expect_success 'start p4d' '
> +	start_p4d
> +'
> +
> +test_expect_success 'init depot with UTF-16 encoded file and artificially remove BOM' '
> +	(
> +		cd "$cli" &&
> +		echo "file1 -text" > .gitattributes &&
Please no space between '>' and the filename,
(this is our coding standard, and the same further down)

> +		perl -e "printf \"$UTF16\"" >file1 &&
Ehh, do we need perl here ?
This will invoke a process-fork, which costs time and cpu load.
The following works for me:
printf '\227\000\227\000' >file1

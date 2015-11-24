From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v4] blame: add support for --[no-]progress option
Date: Tue, 24 Nov 2015 06:57:33 +0100
Message-ID: <5653FC4D.4090201@web.de>
References: <1448327277-29385-1-git-send-email-eantoranz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, j6t@kdbg.org
To: Edmundo Carmona Antoranz <eantoranz@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 24 06:58:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a16cN-0005oW-N6
	for gcvg-git-2@plane.gmane.org; Tue, 24 Nov 2015 06:58:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752879AbbKXF6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 00:58:17 -0500
Received: from mout.web.de ([212.227.15.14]:65361 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752786AbbKXF6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 00:58:16 -0500
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0M0Qxx-1aLVmN2ojl-00uaeX; Tue, 24 Nov 2015 06:57:58
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1448327277-29385-1-git-send-email-eantoranz@gmail.com>
X-Provags-ID: V03:K0:/MldnZ2wW6pGsBK2Dxya86FOiKaPCggWhLgkQnhEQSn2k96wYW+
 hd2aHTeR9lSlrZBNT7aZa8V+Rs1evjWfh+WhueKHSaGIqK/z0t2Cdh/Ss+qEct4t2d8gnRt
 XDbkFYN/1Rhyv2Yh7bq9adeflXSWHz9hxejrEA/hQbHbIWd1ElIZEy/BMgzTROmLAgnMrJV
 fyBkzliqfbJMiBdOiWqQA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cpp/xfONQlU=:HfgSfx2uPz5a8YzWuG9aZ1
 8gwi9n0NCVQKNo3rN0O+ssVzgqs1Qvw9whgCxRzeuc5GNxHEXcIAKuBm444P8DxVCCqGd3JZa
 Ntpmpb5kbaDGZ8me2YBPGqHRIhp/H6pAN4jdQ90rTqNZ4N9YUPiR2XyPVj0lfJoObKmzY0XHi
 uaEMSO/2u7vhLZlOMk4sCyVFPg/76aYQqCH2QUUzpsmlTHGJUH7pnqlh2SKtCGGxSs/OV2hOi
 xaOvNKvQ1dD7fXz8V188+JZxGiQ9OJCec4OeeVmVHk6a1HP5tbk9XOvWrhNnK0M7dWFQL/hkS
 1ey1SwGBvcnMhK4qW+jrLYuLEB0kZk/vgiLXvOf+JoVr+fi9NqHga/6j1RmwCf4pvY86KQV7J
 9iZzIcMfzvzEjspYYg3z8riUZ/LaNMan5aWu+19BILNIt2JRI/CUlhOUfk3lL/vG1rNrOSCpD
 tGZ8KNPYYd5d181u4K4Ebs2Ft71d3RGkmtGN8sxrT3ErbiVYASNgwIWGlbG0mWVkUA+ykA2jX
 eiFM3trARG1wleQRthwHz4CyDdh5dZaha4ZUf/5buaDta8pdcM+FWyMlM5ehK7FbhEBWXJrmJ
 lFFBLFN1DyucQOKZ1hV2HZRi80i96D8eHMC2urLuqryWySYAzM6a+aTgNGWIaLvZ0QYCvCt8F
 VZe+rhv2Zx/u2ETZDJk/Szyevre0YipS/FVhOxs+av5yQs+uQaljvn4naCpiLuDeJCc0BUePG
 a6FAuA47E7L+49xz5h6RM4oZzp3ti6FO0HgpSLNe0VIMWaGLfFlQ950w3CmCnlq+mVcZZ01V 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281609>

On 11/24/2015 02:07 AM, Edmundo Carmona Antoranz wrote:
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 83612f5..1d43b52 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -28,6 +28,7 @@
>   #include "line-range.h"
>   #include "line-log.h"
>   #include "dir.h"
> +#include "progress.h"
>   
>   static char blame_usage[] = N_("git blame [<options>] [<rev-opts>] [<rev>] [--] <file>");
>   
> @@ -50,6 +51,7 @@ static int incremental;
>   static int xdl_opts;
>   static int abbrev = -1;
>   static int no_whole_file_rename;
> +static int show_progress;
>   
>   static struct date_mode blame_date_mode = { DATE_ISO8601 };
>   static size_t blame_date_width;
> @@ -127,6 +129,11 @@ struct origin {
>   	char path[FLEX_ARRAY];
>   };
>   
> +struct progress_info {
> +	struct progress *progress;
> +	int blamed_lines;
> +};
> +
>   static int diff_hunks(mmfile_t *file_a, mmfile_t *file_b, long ctxlen,
>   		      xdl_emit_hunk_consume_func_t hunk_func, void *cb_data)
>   {
> @@ -1746,7 +1753,8 @@ static int emit_one_suspect_detail(struct origin *suspect, int repeat)
>    * The blame_entry is found to be guilty for the range.
>    * Show it in incremental output.
>    */
> -static void found_guilty_entry(struct blame_entry *ent)
> +static void found_guilty_entry(struct blame_entry *ent,
> +			   struct progress_info * pi)
Minor remark: The '*' should be close to the variable: "struct 
progress_info *pi"
>

From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 04/10] archive.c: convert to use struct object_id
Date: Wed, 11 Mar 2015 15:20:08 +0100
Message-ID: <55004F18.4070609@alum.mit.edu>
References: <1425770645-628957-1-git-send-email-sandals@crustytoothpaste.net> <1425770645-628957-5-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Andreas Schwab <schwab@linux-m68k.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 11 15:20:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVhUr-00088T-KP
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 15:20:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752940AbbCKOUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2015 10:20:19 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:58651 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752904AbbCKOUP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Mar 2015 10:20:15 -0400
X-AuditID: 12074411-f79fa6d000006b8a-a6-55004f1af708
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 96.1A.27530.A1F40055; Wed, 11 Mar 2015 10:20:10 -0400 (EDT)
Received: from [192.168.69.130] (p4FC960B5.dip0.t-ipconnect.de [79.201.96.181])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t2BEK8S7007933
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 11 Mar 2015 10:20:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.5.0
In-Reply-To: <1425770645-628957-5-git-send-email-sandals@crustytoothpaste.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsUixO6iqCvlzxBqcLZR0qLrSjeTRdvMH0wW
	/Us72ByYPZbf/MvkcehwB6PH501yAcxR3DZJiSVlwZnpefp2CdwZKyYsZiu4wlax+tEztgbG
	eaxdjJwcEgImEmdnLmWCsMUkLtxbzwZiCwlcZpSYu9Gpi5ELyD7PJPF91UFGkASvgLbE/4X7
	2UFsFgFViTm928Ca2QR0JRb1NIPZogJBEi9v/YWqF5Q4OfMJC4gtIuAlMf/RDLDFzAJaEhMn
	rwRbJizgIdExcTc7xLJ+RokjTTvBFnAK+ElM2/+GBaJBT2LH9V9QzfISzVtnM09gFJiFZMcs
	JGWzkJQtYGRexSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrqpebWaKXmlK6iRESvoI7GGeclDvE
	KMDBqMTD6zDjf4gQa2JZcWXuIUZJDiYlUV5mV4ZQIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8
	4j5AOd6UxMqq1KJ8mJQ0B4uSOC/fEnU/IYH0xJLU7NTUgtQimKwMB4eSBC+jL1CjYFFqempF
	WmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPChW44uB0QqS4gHaexNsb3FBYi5QFKL1FKMux4L2
	/TOZhFjy8vNSpcR534EUCYAUZZTmwa2AJatXjOJAHwvzuoNcwgNMdHCTXgEtYQJawmINDAve
	4pJEhJRUAyNbbNLhUotJfQr7fiW9/m/+2FbxdOdba0Z2/o9Nv55tEp/imOz+QiZe68Le9e92
	99caRHGvK2K0dQ4VujcrIrqlcoc81+/QDdO8Fp9KCzed09+fEqawuP0Yn4J5fpLY 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265326>

On 03/08/2015 12:23 AM, brian m. carlson wrote:
> Convert a hard-coded 20 as well.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  archive.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/archive.c b/archive.c
> index 96057ed..46d9025 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -101,7 +101,7 @@ static void setup_archive_check(struct git_attr_check *check)
>  
>  struct directory {
>  	struct directory *up;
> -	unsigned char sha1[20];
> +	unsigned char sha1[GIT_SHA1_RAWSZ];

This is a local struct, and I think it is only a three-line change to
change the sha1 member to

        struct object_id oid;

Though perhaps you are delaying that change for some concrete reason.

> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu

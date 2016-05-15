From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v1 1/3] t6038; use crlf on all platforms
Date: Sun, 15 May 2016 02:42:38 -0400
Message-ID: <CAPig+cRj_=+hBw_BpBHfJLwBmMH1k8w1S1WMFes2avSOOkc77g@mail.gmail.com>
References: <20160513134953.GE2345@dinwoodie.org>
	<1463294280-20176-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun May 15 08:42:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1plF-0006rk-Qo
	for gcvg-git-2@plane.gmane.org; Sun, 15 May 2016 08:42:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752643AbcEOGmj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2016 02:42:39 -0400
Received: from mail-ig0-f193.google.com ([209.85.213.193]:34975 "EHLO
	mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630AbcEOGmj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 02:42:39 -0400
Received: by mail-ig0-f193.google.com with SMTP id jn6so4531264igb.2
        for <git@vger.kernel.org>; Sat, 14 May 2016 23:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=LtZZTtvfl8YRFzMrfdw35LLgAbSCMJ/eqBpGaI/aZpU=;
        b=ztxpVAZsub+Z692VW5056KC08rZeZY0hdU5DAkOWUgcTWDyh5UFnRz4kABiSvl0ZWN
         dBDBY3MNhaZjeRbCikHhK25ZvtVABmM573906PFmEJ+p0cQtRhQ+8R5+IVMQHKPMwSKJ
         Jcxt6x7XVenTHLb0/D7ZapGVoux0qIzmWYbifXkUy9rb1VXGjnTLP1HQ5cH5xLhEIxLf
         86ewcOUZPVuulZtzn3NeAZJbg85rHXbpqCaOlzNNEKHQ6L01wf/IkRnMZLr9BMKX7It5
         +AHjPQuFl4cCVYi+9SmTSTKuFFCa0SNhqi7vvQ9ekz4C30zSCxLLE2h3x3PNgbZCAHHO
         3qIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=LtZZTtvfl8YRFzMrfdw35LLgAbSCMJ/eqBpGaI/aZpU=;
        b=m7O8MTgpNWrjhI0UPsj4pVKOqwz9Bx28FnM+pNxfEuSsqgmDscXINedLN6D9k2JjaZ
         BUn9jJWocikdcx66hhCNJx1bPVkzpAFcPId+KANcU4HQ8YZshW3sHh7Vh/Mmj9tYE6RL
         sHprSU96dwePd1mRg0BHMswIA0aBHC/H9Y+1u5gLzW3pfZooRQbaVkIfE18W0XaF+5UQ
         pu7n8CNa+UnOSpfDL28lER2bfQnvQxUUXbWJURA/IJ7iIFlWlsynTMU70XBkeb21p49M
         64UlhaGuI9wLD1BorKSKXz0CEET11H+t4veF7YSLplRwIkvuaoDdj03KIkaMSpIlM97P
         xl4w==
X-Gm-Message-State: AOPr4FXUfi/jSacIeeiK1A6qwK14sHoanmT9sTm6pnTgFNSknVrFdpDbXSqIgehDnPMxkbc28ocJrRi3U5b4hQ==
X-Received: by 10.50.6.15 with SMTP id w15mr7272843igw.91.1463294558226; Sat,
 14 May 2016 23:42:38 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Sat, 14 May 2016 23:42:38 -0700 (PDT)
In-Reply-To: <1463294280-20176-1-git-send-email-tboegi@web.de>
X-Google-Sender-Auth: QHD5Yq5nlnAArbyXWGxUngfc3zw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294642>

On Sun, May 15, 2016 at 2:38 AM,  <tboegi@web.de> wrote:
> t6038 uses different code, dependig if NATIVE_CRLF is set ot not.

s/dependig/depending/
s/ot/or/

> When the native line endings are LF, merge.renormalize is not tested very well.
> Change the test to always use CRLF by setting core.eol=crlf.
> After doing so, the test fails:
> [...snip...]
> This will be addressed in the next commit.

Does this mean that the below tests now fail? If so, they should be
switched to use test_expect_failure here, and then swapped back to
test_expect_success in the patch which fixes the problem.

> ---
> diff --git a/t/t6038-merge-text-auto.sh b/t/t6038-merge-text-auto.sh
> index 85c10b0..4dc8c1a 100755
> --- a/t/t6038-merge-text-auto.sh
> +++ b/t/t6038-merge-text-auto.sh
> @@ -18,6 +18,7 @@ test_have_prereq SED_STRIPS_CR && SED_OPTIONS=-b
>
>  test_expect_success setup '
>         git config core.autocrlf false &&
> +       git config core.eol crlf &&
>
>         echo first line | append_cr >file &&
>         echo first line >control_file &&
> @@ -72,10 +73,8 @@ test_expect_success 'Merge after setting text=auto' '
>         same line
>         EOF
>
> -       if test_have_prereq NATIVE_CRLF; then
> -               append_cr <expected >expected.temp &&
> -               mv expected.temp expected
> -       fi &&
> +       append_cr <expected >expected.temp &&
> +       mv expected.temp expected &&
>         git config merge.renormalize true &&
>         git rm -fr . &&
>         rm -f .gitattributes &&
> @@ -90,10 +89,8 @@ test_expect_success 'Merge addition of text=auto' '
>         same line
>         EOF
>
> -       if test_have_prereq NATIVE_CRLF; then
> -               append_cr <expected >expected.temp &&
> -               mv expected.temp expected
> -       fi &&
> +       append_cr <expected >expected.temp &&
> +       mv expected.temp expected &&
>         git config merge.renormalize true &&
>         git rm -fr . &&
>         rm -f .gitattributes &&
> @@ -104,15 +101,9 @@ test_expect_success 'Merge addition of text=auto' '
>
>  test_expect_success 'Detect CRLF/LF conflict after setting text=auto' '
>         echo "<<<<<<<" >expected &&
> -       if test_have_prereq NATIVE_CRLF; then
> -               echo first line | append_cr >>expected &&
> -               echo same line | append_cr >>expected &&
> -               echo ======= | append_cr >>expected
> -       else
> -               echo first line >>expected &&
> -               echo same line >>expected &&
> -               echo ======= >>expected
> -       fi &&
> +       echo first line | append_cr >>expected &&
> +       echo same line | append_cr >>expected &&
> +       echo ======= | append_cr >>expected &&
>         echo first line | append_cr >>expected &&
>         echo same line | append_cr >>expected &&
>         echo ">>>>>>>" >>expected &&
> @@ -128,15 +119,9 @@ test_expect_success 'Detect LF/CRLF conflict from addition of text=auto' '
>         echo "<<<<<<<" >expected &&
>         echo first line | append_cr >>expected &&
>         echo same line | append_cr >>expected &&
> -       if test_have_prereq NATIVE_CRLF; then
> -               echo ======= | append_cr >>expected &&
> -               echo first line | append_cr >>expected &&
> -               echo same line | append_cr >>expected
> -       else
> -               echo ======= >>expected &&
> -               echo first line >>expected &&
> -               echo same line >>expected
> -       fi &&
> +       echo ======= | append_cr >>expected &&
> +       echo first line | append_cr >>expected &&
> +       echo same line | append_cr >>expected &&
>         echo ">>>>>>>" >>expected &&
>         git config merge.renormalize false &&
>         rm -f .gitattributes &&
> --
> 2.0.0.rc1.6318.g0c2c796

From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [WIP/PATCH v4 6/8] for-each-ref: rename some functions and make
 them public
Date: Sat, 30 May 2015 23:21:02 -0400
Message-ID: <CAPig+cTyy5ai0O4BAG+3+_6x-8OC5SoUDR=swCq-bNFP3DfxUg@mail.gmail.com>
References: <5569EF77.4010300@gmail.com>
	<1433008411-8550-6-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 31 05:21:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YytoD-0005dc-9M
	for gcvg-git-2@plane.gmane.org; Sun, 31 May 2015 05:21:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbbEaDVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2015 23:21:05 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37422 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932245AbbEaDVD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2015 23:21:03 -0400
Received: by igbsb11 with SMTP id sb11so40121809igb.0
        for <git@vger.kernel.org>; Sat, 30 May 2015 20:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=2xsJu4ivougxjvEQC9qg40npO8UyeJBZsysl7u2mUUg=;
        b=zEVvEToS9pcSYK3rRdCBogbzZMH82ZQKErTJp6aW6sCvF+vZ+hmV0tsw7Ocnsf0vdf
         1V1E0BHxEviqseIWnupm7uC/CICDcdE0zC13mH/jYL1fmE/iLwWwfiJsXChLwexjyKVe
         ChxgIgzI/Xq33GQNy5CVbFTMAV8BTWlXG/97vT3gESwPTyQhv6aq2HMYQ1Sd7bFMiOku
         3AjeGPHQES4SwLE4PZkzlrQmOHaUY/gE9ormxcZdcrbHQaOEOtEgOOoYb3rFc+4ei5aq
         g+Gm49YOTULoUu6EXI/mHYk/4yLohAM0aYfKqv+V+NqwhsDkqQ6elIr2+/Fd+r7hL8LA
         RAfQ==
X-Received: by 10.43.135.5 with SMTP id ie5mr22894217icc.78.1433042462861;
 Sat, 30 May 2015 20:21:02 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Sat, 30 May 2015 20:21:02 -0700 (PDT)
In-Reply-To: <1433008411-8550-6-git-send-email-karthik.188@gmail.com>
X-Google-Sender-Auth: 4GSkz1TfoqYOaR3KHS6Kk48AzWs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270313>

On Sat, May 30, 2015 at 1:53 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Rename some of the functions and make them publically available.

s/publically/publicly/

> This is a preparatory step for moving code from 'for-each-ref'
> to 'ref-filter' to make meaningful, targeted services available to
> other commands via public APIs.
>
> Based-on-patch-by: Jeff King <peff@peff.net>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index f896e1c..8fed04b 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -882,10 +882,10 @@ static struct ref_array_item *new_ref_array_item(const char *refname,
>  }
>
>  /*
> - * A call-back given to for_each_ref().  Filter refs and keep them for
> + * A call-back given to for_each_ref(). Filter refs and keep them for

Sneaking in whitespace change?

>   * later object processing.
>   */
> -static int grab_single_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
> +int ref_filter_handler(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
>  {
>         struct ref_filter_cbdata *ref_cbdata = cb_data;
>         struct ref_filter *filter = &ref_cbdata->filter;

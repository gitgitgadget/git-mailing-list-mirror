From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [WIP/PATCH v4 6/8] for-each-ref: rename some functions and make
 them public
Date: Sun, 31 May 2015 10:04:32 +0200
Message-ID: <CAP8UFD080Yuv-CYcDzAG0u6OV7Sqry=0s1HKoJbt5wfKjTNO3Q@mail.gmail.com>
References: <5569EF77.4010300@gmail.com>
	<1433008411-8550-6-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 31 10:04:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyyEq-0001TD-1p
	for gcvg-git-2@plane.gmane.org; Sun, 31 May 2015 10:04:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758088AbbEaIEi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 04:04:38 -0400
Received: from mail-wg0-f48.google.com ([74.125.82.48]:34019 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754364AbbEaIEe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 04:04:34 -0400
Received: by wgv5 with SMTP id 5so91696799wgv.1
        for <git@vger.kernel.org>; Sun, 31 May 2015 01:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jQDZleJQ8UsCeL5BEueSlyslqnwvrB1EM3IzM+J0nXA=;
        b=lImrOl4U1HMMC2yrynhokhw93Ym1C2jOgccNX6BPsgP0OonS1DVDTp+9GC9SUcuHem
         JcX+r2mxT9PjcY8x3ua2FuQAft0nrXrZXTWYsnRc5uJNMdXzzelbN4dobYB4lgHbEVMC
         7HpwENrg85B6o/thUW041eWR41I9tIg1RfFEOJo8sxvWzOfgj+EChPJ09V8kHnfQu26F
         A1mevIVF2++ffke/pXTsiXiLT1uSGUwen1P+29+Y60ogzkSgLhEI7ep+Bza95E6EJ9OM
         QeqWgPRlJ3f/hzaauzP5vTrlXqPFZXo6YPBvi78J0jr1f90q8snOIxJWvuEb0hejklLZ
         kzSA==
X-Received: by 10.194.178.227 with SMTP id db3mr17513486wjc.82.1433059472730;
 Sun, 31 May 2015 01:04:32 -0700 (PDT)
Received: by 10.194.40.8 with HTTP; Sun, 31 May 2015 01:04:32 -0700 (PDT)
In-Reply-To: <1433008411-8550-6-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270316>

On Sat, May 30, 2015 at 7:53 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>
> -static void sort_refs(struct ref_sort *sort, struct ref_array *array)
> +void sort_ref_array(struct ref_sort *sort, struct ref_array *array)

It is probably better to call the above function ref_array_sort()...

[...]

> -static struct ref_sort *default_sort(void)
> +/*  If no sorting option is given, use refname to sort as default */
> +struct ref_sort *ref_default_sort(void)

... especially since you call the above ref_default_sort()...

> -static int opt_parse_sort(const struct option *opt, const char *arg, int unset)
> +int opt_parse_ref_sort(const struct option *opt, const char *arg, int unset)

... and the above opt_parse_sort().

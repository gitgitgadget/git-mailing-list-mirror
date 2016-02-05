From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 21/25] fetch: define shallow boundary with --shallow-exclude
Date: Fri, 5 Feb 2016 00:26:43 -0500
Message-ID: <CAPig+cQA6yV369b7hM_Q8aPuAwF8tR1xT=jr1r2PH1KsCtHWtQ@mail.gmail.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
	<1454576641-29615-22-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 06:27:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRYvF-0007Xe-QW
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 06:27:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752263AbcBEF07 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2016 00:26:59 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:32794 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354AbcBEF0o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Feb 2016 00:26:44 -0500
Received: by mail-vk0-f68.google.com with SMTP id c3so174840vkb.0
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 21:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=jib2FZs4l0VgUKMR2etX1YKA8/BEimAfRaabQmxJS2s=;
        b=l9hMitJV6/xt4lYo3l+PEZNwM8k1RDOjpfUHQAfPPcgZyDMgIG+NsQc5RfiH/0fmdf
         SMVCQSDCssVjFPeyXb2XtkdSp+32tPijVNWxmZRevaSLM5imS8iNEv0PjZK5NeplvfmX
         kgiJthEzuMznO7hiPEbT+ZVfA4/LbLp3FmGgb20KEHow5JESj9nuv+jbnvWnbf9t6NPe
         g9fZ/XTfm5eKSPMYwBPabW6psV/+v5Qmt3ibbV8/bP1KpI2I2nZNjOgExocF71r3tRQw
         Xm5bXS7we/qnTETKV8eYBXimOSrwehmsXrXsHCtxPUxGnEXD8weq3cgA9XTYyYuAj4bI
         +Z+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jib2FZs4l0VgUKMR2etX1YKA8/BEimAfRaabQmxJS2s=;
        b=kfWLeypY4l0G1ecnbnAgo1S4+HfQCiv82sqAS1kWWngU10hdoeaX9fKnHCf9sBd8Qd
         i9OGJtCPMWxWh8h+W20gK3SGP9YqEkruVWCVh4YsHrAFiXQIcAIKlGcC5rq7FbpuGStk
         IFWdHdctjL1XpjalrXuAbYsYpFNPkNP6TurVqYHh8BQPlizV/R9ZhuA6zZG7txqJKn5z
         ScDs/zuQwnsQU+9kikKNFnGJ2qXuMsLLbbtAdLzGagHSkc1zqmHOIkRijkZpC7WpDMKR
         OicaV+68zv72d84YhtPuFEOivsQWGmltVtVjZtXXpU6mEdTmYE/u7QUPz2NQm3KDqgGi
         N79g==
X-Gm-Message-State: AG10YOQC9dmURyg5i1+60xwLzd7lviUl8pW5BEVSILVcVq1bGBVMPdtRI/t29cNO81e+fa6txMlNgP0B3Tf/yw==
X-Received: by 10.31.41.14 with SMTP id p14mr8029061vkp.151.1454650003456;
 Thu, 04 Feb 2016 21:26:43 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Thu, 4 Feb 2016 21:26:43 -0800 (PST)
In-Reply-To: <1454576641-29615-22-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: 2delDGOSRfZ3UxKqcbJgiKlobCE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285540>

On Thu, Feb 4, 2016 at 4:03 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
> @@ -109,6 +109,16 @@ int cmd_fetch_pack(int argc, const char **argv, =
const char *prefix)
> +               if (skip_prefix(arg, "--shallow-exclude=3D", &value))=
 {
> +                       static struct string_list *deepen_not;
> +                       if (!deepen_not) {
> +                               deepen_not =3D xmalloc(sizeof(*deepen=
_not));
> +                               string_list_init(deepen_not, 1);
> +                               args.deepen_not =3D deepen_not;
> +                       }
> +                       string_list_append(deepen_not, value);
> +                       continue;
> +               }

Hmm, can't this be simplified to:

    if (skip_prefix(arg, "--shallow-exclude=3D", &value)) {
        if (!args.deepen_not) {
            args.deepen_not =3D xmalloc(sizeof(*args.deepen_not));
            string_list_init(args.deepen_not, 1);
        }
        string_list_append(args.deepen_not, value);
        continue;
    }

Or, perhaps even better, declare it as plain 'struct string_list
deepen_not' in struct fetch_pack_args, rather than as a pointer, and
then in cmd_fetch_pack():

    memset(&args, 0, sizeof(args));
    args.uploadpack =3D "git-upload-pack";
    string_list_init(&args.deepen_not, 1);

    ...

    if (skip_prefix(arg, "--shallow-exclude=3D", &value)) {
        string_list_append(args.deepen_not, value);
        continue;
    }

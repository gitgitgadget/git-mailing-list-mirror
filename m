From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 3/4] submodule--helper list: lose the extra prefix option
Date: Fri, 25 Mar 2016 09:49:56 -0700
Message-ID: <CAGZ79kZ684W46df9zPQATr3zWKt+e1BhGY6DZ84psfXWH4tGNw@mail.gmail.com>
References: <1458862468-12460-1-git-send-email-sbeller@google.com>
	<1458862468-12460-4-git-send-email-sbeller@google.com>
	<xmqqmvpn5awo.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jacob Keller <jacob.keller@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 17:50:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajUvz-0005pH-2m
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 17:50:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753688AbcCYQt7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 12:49:59 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:36304 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753372AbcCYQt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 12:49:58 -0400
Received: by mail-io0-f179.google.com with SMTP id 124so118019308iov.3
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 09:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=Go31bJ2WMxnco2lcXnvKy4VJzaYKGzBuBbMQavOloDo=;
        b=LCf1y049cxVfNA7nmX9PLz3JJmKgUAnVABrPIqHNj5lXDelKVLKvC/wnh2cOft6dLJ
         QQnXxVAOKzhxg+6sMNhiDcgX6SGxgGmpq5qMdAVC5eI9SQ/O+8VmpTrkDV9frIk3U36S
         7OmkaoZJHIgnQOoiYZSFHUbUJJYTqVtr7PEpcX6lZ7PgEsj7dw2LMQDoW0uvcFmQ2Yl9
         nRoroOEhWfdDT7X7wLTDGkeSw/Sae1mXeiFm/b7KVz4l4/FHThg6rbgjjNRTjdX5Cam2
         AHqOwSLOwyZ6bblJGA1gxtnn0M9BrnyzalIqsjhSb2enf8MSg/EliXOv0+4tOifCgBVM
         DD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Go31bJ2WMxnco2lcXnvKy4VJzaYKGzBuBbMQavOloDo=;
        b=fNG/vIucSxi1Ko09Rz4mvqrwHH6ituu8bj/VmUEgbCP0fyMooV2vkQpQSU/viIQ92/
         AfvzKOt4+sh/CTC8Nvd8neKECjcj1Qg1XQpe98GyI0wQPd8snxhxnk0uY1aydRP1i34U
         CjFYYE7u/8r//FWU6pUKupDmCjAbolB2uWm0Ni9kCXKL+sZnpcUCa2e2qp1sC6S9AKi9
         yTpH8xdzAUOu5GzkXoWOnxRwwJaCB4CYKp/J4fHi2i92/wHvAchQDTUVTKVA6IyzuGqY
         1EU44QaiheyXvHzPXeP1cxxAQQuW9xsrlRGi5FjOLqtkiwGKuotLlQSBZKDSPwVPEuHV
         r79Q==
X-Gm-Message-State: AD7BkJL8d8MdhIVE4/eIbegx7V2Mj4mTIkjNEIURLxH5ob7phmHEDPCoir93pdPfxvk9AKcCAWWpS1e4F6r2gcms
X-Received: by 10.107.131.163 with SMTP id n35mr16800494ioi.110.1458924597145;
 Fri, 25 Mar 2016 09:49:57 -0700 (PDT)
Received: by 10.107.132.101 with HTTP; Fri, 25 Mar 2016 09:49:56 -0700 (PDT)
In-Reply-To: <xmqqmvpn5awo.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289903>

On Thu, Mar 24, 2016 at 11:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> So this change may not be wrong per-se, but if the lossage of prefix
> is the final goal (as opposed to an approach to gain other benefits,
> e.g. "now we do not have to use prefix, we can simplify these other
> things"), I do not know if it is worth it.
>

It is the final goal of this series. As motivation, see Jacobs comment above:

    I had wondered why we used --prefix before.

Also when the submodule helper got in, reviewers (Jonathan) were confused and
asked for clarification of the prefix term. So either document the prefix term
(and come up with a reason why we don't use the standard mechanism,
which as you outlined in the other mail, may be performance as we skip one
chdir, but that sounds like weak argument to me) or remove the confusing part
of having a prefix, which is not the standard prefix inside C.

The other reason you gave below is also convincing: By having it in the prefix,
the C code is more likely correct and future proof.

On rewriting the whole submodule command in C (probably reiterating):
It is not my endgoal to rewrite every submodule related part in C. It
would be nice
if it would happen eventually, but for now I only rewrite parts that I
need in C. (i.e.
paralllelisation is hard in shell, if not impossible using posix shell
with no additional
dependencies [xargs, gnu parallel], so I moved that part to C.
Certain parts need a performance boost? Ok I'll do it in C.

That said, we may have the shell/C architecture for a longer time than planned,
which makes it important to comment/document the confusing parts. Instead
I'd rather not have confusing parts, so I see benefit in having the
goal of this series
to remove the --prefix.

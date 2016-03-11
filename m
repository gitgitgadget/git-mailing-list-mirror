From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: Re: [PATCH v7 2/2] pull --rebase: add --[no-]autostash flag
Date: Fri, 11 Mar 2016 20:08:23 +0530
Message-ID: <CA+DCAeTRavhVb05sXsi-P5NKGw7xRAZLnc2-XC+8f6ZWZgsJhA@mail.gmail.com>
References: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
	<1457497100-13045-1-git-send-email-mehul.jain2029@gmail.com>
	<1457497100-13045-2-git-send-email-mehul.jain2029@gmail.com>
	<CACRoPnRESpiNL_=rEgw7kRdKjek8Z=qVjPH=BEWsWeYn22YryQ@mail.gmail.com>
	<CA+DCAeSvjyy6WO=n-wdo3_yHGSWmUC0Epbt-OYLF_fbuczeeKA@mail.gmail.com>
	<vpq8u1p16rv.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 11 15:38:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeOD2-0004Ne-V2
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 15:38:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbcCKOi0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2016 09:38:26 -0500
Received: from mail-qg0-f43.google.com ([209.85.192.43]:35945 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752925AbcCKOiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2016 09:38:25 -0500
Received: by mail-qg0-f43.google.com with SMTP id u110so99395024qge.3
        for <git@vger.kernel.org>; Fri, 11 Mar 2016 06:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=O9c4UFoZvCN/8UP4YqHQ3DcszWMWs2gPKq5ZGzSl7fQ=;
        b=V4SKJg+oEoMrqtOFrehSzeFnWKxIbL0wvOwhx21NUhUPk4Kzqx/19lmVX8a3ShZtQg
         D59SdqWJh+B0yT7lqafm6M7jajXbguAUMZs1zhtgkunL42hHpB4KZQcg+lIwL3zyQapl
         zwU+kIWxQVR9Je6CvSQAgjYKJ4crp2FWpsGSIgGAI7TP/gZRYX/CDPxRxAetR4fqMj0U
         4X+ZsOHJUhr49io5KBt4YkSTdOzdmoEEOj0/bOKwnV74mkmhn6u/3bw4L0YJU3mT/E10
         UrCGEYhNL4CUfJYi8vDMYK4eKdko7gr9e45j37BpDhf8Vy+a9YaxjdZI70/dAB57xGrO
         bEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=O9c4UFoZvCN/8UP4YqHQ3DcszWMWs2gPKq5ZGzSl7fQ=;
        b=gMjqp7MxP3SM4gGt152GNmcC4h7zv7NMSt+AmKSfmyp0zUh2Rh0fwnWieyk9Bsf/2K
         0MLRTOf8wXA2uucUqwRIbB2aFar593ChK1jcmTZ+pkN5U0ngqdp2ifhvUSTO1/A5k9+Y
         wYs+U6lQPiHzIp4h8sUNpEwXYEtgyrsZXvzqtsaioEe7yG9IUxsT7+bR9Y/4JbNjVp4Q
         I0OaqkrNMrwd3l5M00P8XzjWuuXRqLLMF+zNlDR2zXWhR/eeDqgr9JrNOvxdHZfhBfe+
         qgQyF88oN+2l/rROWa5M1go2RcBtWQs6ZCa1J6uNcZMMScIm504W03wXAncyiITEdvQY
         zbyg==
X-Gm-Message-State: AD7BkJKNImVp1FsZLPe6SV2XZcbv6J8vUO1QTO6MlbBGFlxA2Er7GaREl1DNF4xwubJ0R30tffJVZclpE9DXfw==
X-Received: by 10.140.21.229 with SMTP id 92mr12280468qgl.89.1457707103853;
 Fri, 11 Mar 2016 06:38:23 -0800 (PST)
Received: by 10.55.188.7 with HTTP; Fri, 11 Mar 2016 06:38:23 -0800 (PST)
In-Reply-To: <vpq8u1p16rv.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288687>

On Fri, Mar 11, 2016 at 7:00 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> What Junio says is that you don't need to write
>
> static int config_autostash = 0;
>
> since it is equivalent to
>
> static int config_autostash;
>
> But there's nothing wrong with having a static variable defaulting to 0.

My bad. I should have read Junio's comment more carefully.

config_autostash can be default to 0. And thus
             if (opt_autostash != 1)
                    die_on_unclean_work_tree(prefix);

can be replaced by
           if (!opt_autostash)
                    die_on_unclean_work_tree(prefix);

and thus opt_autostash will be either 0 or 1 and we don't
have to worry about it being -1 (whenever --rebase is passed).

I will make the changes accordingly.

Thanks,
Mehul

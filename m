From: Stefan Beller <sbeller@google.com>
Subject: Re: Tabs in commit messages - de-tabify option in strbuf_stripspace()?
Date: Tue, 15 Mar 2016 18:02:03 -0700
Message-ID: <CAGZ79kZtAm1M=9CGDGxPdecXEuNEQcbpQb3FNj9=Py0VE2UrKQ@mail.gmail.com>
References: <CA+55aFzHMp4hiCp7+2Yxy=KNQ_rBru3RM-pghXUPtoxr_L+w2w@mail.gmail.com>
	<xmqq4mc76yji.fsf@gitster.mtv.corp.google.com>
	<CA+55aFyXXHNrJW56A_DKkmrmGpWxeUd6row_ja3bzqhs_yswhw@mail.gmail.com>
	<CAGZ79kZihaftwwmY23mZ_i4H6vv2Z9r=LC68M0MMD1o2h2Z4Sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Mar 16 02:02:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afzqk-00017K-Op
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 02:02:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933912AbcCPBCH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 21:02:07 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:37859 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932337AbcCPBCE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 21:02:04 -0400
Received: by mail-ig0-f180.google.com with SMTP id mh10so29709933igb.0
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 18:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=6pQjTSG2k1pvbCVGbRQb3aCR/rpAPl504D1Wp8ljes4=;
        b=HIKdY9pObP2xGivTTnHezn2NDdxi7y/P9xQjpqlhBqR8VGvv6VCS7pH9SZc0i+NEeJ
         fWEH1UBWbFFHWYsurxF2ia+fv50ShliVkPPGRqzVJN4yPUksFodIa0aZmGA6y+nO0Ugv
         jjoBmNrgTRx1MqJ8LZT8oirirllQ4+dw29ViaExGgnMAaKiF2BHogYeHNaoTMocSNogg
         ay1r6U8wVYtfrOzUW+vGIr4T/ap6lISIgACHV1jggoA60k43iIpktW6pkZBlYddcQ+jh
         WxgYwlp20eecil02oOnRdmVc9Z+pbfun8uRBAS/ewKDlsn+BG0zyyU/yTI4i1dg7aYql
         u2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=6pQjTSG2k1pvbCVGbRQb3aCR/rpAPl504D1Wp8ljes4=;
        b=dNTbzs0lbM6kb0nMY67mv50IrCGRG8k10Z1wMHM9Eoevjs9mZMomeTXvqkLQV9K8Yx
         B/LslyFwE0Z0nKeIgYCzx9ibZ+J+BnqqfILBLDOvwJ3Xv4x02WNagrrNTASmaWu7g/Fk
         lEJY8+LWnerbW+SqBg2bCkAezJnRKPPcg+kjMXLFSaRLA/XcGd+D0aQDybDcsht/EKu8
         d1j6yz7sNsQpWZ//+DWlCqmasmNYKWUk8i8OV5ZqoQ7mnZEgbe17mFz+WrokTYFA+oev
         lc4n71ILzOxnqd1NVHEs67ZjGjgo3K1xa8ckyyAfUSz8wvwurVQlOQd/GFzmWA/1eowh
         mEiw==
X-Gm-Message-State: AD7BkJJVCRo//A8Qx+HNxoZbwLXTUV1QoZ4Z6K4z3YxI9gAra99nSS7uouo9gXG0w8v8IfxStpn9DIQPdaLxkYNr
X-Received: by 10.50.23.43 with SMTP id j11mr13721042igf.94.1458090123964;
 Tue, 15 Mar 2016 18:02:03 -0700 (PDT)
Received: by 10.107.132.101 with HTTP; Tue, 15 Mar 2016 18:02:03 -0700 (PDT)
In-Reply-To: <CAGZ79kZihaftwwmY23mZ_i4H6vv2Z9r=LC68M0MMD1o2h2Z4Sw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288937>

On Tue, Mar 15, 2016 at 6:00 PM, Stefan Beller <sbeller@google.com> wrote:
>
> Instead of converting to whitespaces in Git, we could make use of the
> set_tabs capability for ttys and setup the terminal for having tabs align
> to 12,+8,+8,+8...

Or rather read in the existing tabs configuration and shift it by a constant.

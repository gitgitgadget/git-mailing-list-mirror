From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 00/27] nd/shallow-deepen updates
Date: Tue, 14 Jun 2016 16:21:22 +0700
Message-ID: <CACsJy8BAawP+599R7iKYcEa+DJ=Gc_Zv11ma5SSqA0eCki1p=g@mail.gmail.com>
References: <20160610122714.3341-1-pclouds@gmail.com> <CAPig+cRfUjpku1Abf=GxrbFeS4txwr=yZsJ7EKo-aWmxYog6Xw@mail.gmail.com>
 <xmqqr3c1c8we.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 11:21:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCkXm-0005ph-NV
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 11:21:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbcFNJVy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 05:21:54 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:33565 "EHLO
	mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243AbcFNJVx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 05:21:53 -0400
Received: by mail-it0-f67.google.com with SMTP id i6so10474227ith.0
        for <git@vger.kernel.org>; Tue, 14 Jun 2016 02:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=anSuYKYDQG819Yl87TCRw+B8LAYb55bx/U/rzU0te24=;
        b=Km4jdGpaw74LCXyje7iWp5849PD5ZZVQhJ4jArrUEloSxTpdWtb3rS/ioxh7uaTbbk
         WsxJjbLqlTXQd/9N8qDlKaiecIFVLz8vRCqluG6iWGrn1/ahfYLsyNdHopXL4Bw7lQr7
         d50I9Jm6g5HWGJZg3UBopKQ9qhOZb4wfoAfRbRbbOw+L0qQAXJiK5bD5TeLbd0r/H70I
         5G9YORohfQwziZsTonHw/OMbuAAE7DMjDW2ZGq4xj7v3pjFWurf+EtmW23HGGfSZDh/y
         66AbMc2rL9pP4OeUfKZdacrURKupNiRA/neXtEHoA9/XIlhQNeajERJ60sCUDZV6Du4r
         uSTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=anSuYKYDQG819Yl87TCRw+B8LAYb55bx/U/rzU0te24=;
        b=NpAK+MoC3BI4fIy8aRZGSWJ9qN9XTs/TuHWW84YxOBghTnC5f1wMSeqzyYQ52wJ0rd
         mtdsLGDmlmiL/JbGdfBjYyD6a93EgNNyiHwoJGJOChiDg7hSlujG28D/r3+DbQ3CaPbn
         +FkKknW5Sxry6QANdOAKHSzgga77CJWfrely/CiDt9L4fmDwjzzZ0MDEFEAek8IJVS9z
         qFQvVyJkGIZIm765x0FZoRWIn5mzqgESMYB59vfeRfBReNZsXR5PLJMtHgOoX8UjxdP8
         9p3H9kEumxds+8/sYHctAeh6a4ir1C06F8GQAcIzFfclPUwI1weOBYoqJFiWGnU4LwC8
         okrw==
X-Gm-Message-State: ALyK8tIFRk4pJtGkb8+PFrLRs7uc0UnqaGM4S2Ma56lh1PWJah1xhXEzRKn3mEVGpUV9CRE6y7ImeHwAC/tIiw==
X-Received: by 10.36.82.8 with SMTP id d8mr25554543itb.57.1465896112364; Tue,
 14 Jun 2016 02:21:52 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Tue, 14 Jun 2016 02:21:22 -0700 (PDT)
In-Reply-To: <xmqqr3c1c8we.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297276>

On Tue, Jun 14, 2016 at 12:10 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> I agree with Junio that moving the sigchain_pop() into the error
>> handling code-path, if possible, would be a nice improvement.
>
> Yeah, "if possible" is really what I was not sure about---is it safe
> to do the _push() thing before start_command(), which presumably
> would affect both the main and the forked processes?

Good point. But we do exec() very shortly in the forked process, which
should reset signal table back to default. So probably not a bad
thing.
-- 
Duy

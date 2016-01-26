From: Andrew Wheeler <awheeler@motorola.com>
Subject: Re: [PATCH] push --force-with-lease: Fix ref status reporting
Date: Mon, 25 Jan 2016 20:36:57 -0600
Message-ID: <CAE=k0mt=wCA+evSXdDp1w5n5r34pyNoKvz14wfLdwzVTS+jGVQ@mail.gmail.com>
References: <1453346248-4489-1-git-send-email-agwheeler@gmail.com> <xmqqvb6hfo1u.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andrew Wheeler <agwheeler@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 03:37:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNtVU-00005I-77
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 03:37:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756878AbcAZChT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 21:37:19 -0500
Received: from mail-vk0-f45.google.com ([209.85.213.45]:36739 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756758AbcAZChS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 21:37:18 -0500
Received: by mail-vk0-f45.google.com with SMTP id n1so84612353vkb.3
        for <git@vger.kernel.org>; Mon, 25 Jan 2016 18:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=motorola-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+0Rk5YtM4PeuLBFoBRgXdsSKEI5SGyefSxMxuhKfLhQ=;
        b=J2d+w90c4i8gJwA6mPlr7R9rJhvjcAYQ/pRTMDC9dte1RjIN9AvgSGuXMDMJZcus8k
         mVzByQosfTynHGev1+TW6e1CktFwUEJDiLrF4KFxG4c5/x0RCP3z9OPlxmCnqHb5d8a6
         VIks/xJwb/TaxbknuMNDL262wz0XQB17u8eX94N3Np+XRP0IiX8V7rEfOzd1xkRFp7+l
         DMEP5nH7+DDFc+KrZjsGcdf4NWfFfarvXenctGxljufs1srm2w917s/CeTXwOAy5cA/u
         yRgDf0Tju6GKNHtL+HPJCHo4DK5OjKwgzc3MwPGd0kU7lk1u6rvsm+SUP2QkjDf2cSBE
         etAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=+0Rk5YtM4PeuLBFoBRgXdsSKEI5SGyefSxMxuhKfLhQ=;
        b=SQk6xZ0Br9ajSSdR2evzjHtDeilPFnjTZ9FHOvdfYOuKBB3dBaTBfRjQMR4AGpt+TQ
         wVY5xQN8nuCjFWFtuFjmsFcLf7btLqtZoe26UQd3q6oiRXqHcyXYZQOpU5qj3eybZ94h
         omVgemTFk2krnvmCInHidRm3TswEiRwhrfVmu/WsLHH091TFHwyRBmOMJQq0zslhfF0X
         i6emcUhjHlKfL3QBAIAovsXSssm4v3d4RXJOe/a3wkj8ERLQWXcEE3YOAAGQQnjKjLtS
         B96Yzag/dYgHgY8wp+cXnG60BPnwfuSIm2deP2lGCt/GSoPFQDe0/pTVN5Ipq7UegLCA
         HB+Q==
X-Gm-Message-State: AG10YOSAMXN7J6H+ngs3SAIZuK5XcQH5IqsfVLJf/jzawC8YfTjPTWqYFUoKrmYq4zsHh+d0EdJW3Fz1+dM1HLem
X-Received: by 10.31.8.83 with SMTP id 80mr13084516vki.105.1453775837281; Mon,
 25 Jan 2016 18:37:17 -0800 (PST)
Received: by 10.103.84.77 with HTTP; Mon, 25 Jan 2016 18:36:57 -0800 (PST)
In-Reply-To: <xmqqvb6hfo1u.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284772>

On Mon, Jan 25, 2016 at 1:37 PM, Junio C Hamano <gitster@pobox.com> wrote:

> >                *     passing the --force argument
> > +              *
>
> This new blank line is probably unwanted.


> Do we want to make sure that other people will not break this fix in
> the future by adding a few tests, perhaps to t/t5533?
>
> Thanks.
>

Great idea. I'll add some tests to t/t5533, remove that blank line
above, and share a new patch.

Thanks for the review!

-andrew

From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 48/94] builtin/apply: rename 'prefix_' parameter to 'prefix'
Date: Fri, 13 May 2016 21:42:35 +0200
Message-ID: <CAP8UFD2i9rDi4K=2_hKmEwjtCgnkP6Bi6gFMymPgu2t-qsdA6g@mail.gmail.com>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
	<20160511131745.2914-49-chriscool@tuxfamily.org>
	<xmqqbn4bdp8f.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 13 21:42:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1Iyw-0000NA-8B
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 21:42:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbcEMTmh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 15:42:37 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34339 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932116AbcEMTmg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 15:42:36 -0400
Received: by mail-wm0-f65.google.com with SMTP id n129so5583706wmn.1
        for <git@vger.kernel.org>; Fri, 13 May 2016 12:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=Bvve0TfrhoumfDSKPIZptNYdaor24v9RZxAyWYoZY0Y=;
        b=q2jSG1Atk0Q1foca8i+5JbLTAg5UgeS4bou1Al2iGtgEN+NjNUbrOCUUBe4OTXsztu
         9S4LB8DUpaLEfh+2ghiLFLMJxmyidmXYuiP3AmM7gpKln3RkzZLyMPCANnYjCzoAMB52
         Hycvlke6+zy3qdgZKrogR2v+KFDmKrs8F70gFZQhhc2rwdDF8pFS+MrhuEYT7WA1SoEv
         SJO6sqLRRzU/ID7P/ywHwepPjeOgOSBAXgpGlzztGlycNgszsgzxZdY1BoyEHCGBY/zX
         /Sg6q0YUe7+JFbqmqPR+VOwRuybKRMfcuG7UC3cjNmUOaMsBH4iMH6rg0Z6amX2/XHm9
         O9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Bvve0TfrhoumfDSKPIZptNYdaor24v9RZxAyWYoZY0Y=;
        b=CMdbjCo3oz1V0Znj2zi87SFI/3teFFx4XyPYbVQec0DkY3y0DNP+5Qf1F4Okm0wz0k
         nVHGtrlpemalmeGuBmx9ZDvn4kfyAvU4VAcfrs71MlsVHA19pXajpYMDyW6FIESfx4b2
         O23PAkIVRl4lEPi5ja017MJKSuvyG0A6eOjKfVpYn5mN249kTPisYwmrVK/rIvj00KU6
         lBwDckCspIdbg6rRVfy7lRpOS4d2IDWb+DbR3I1sRpRvasrwHJ5wAGF6DJkbNmQsxlkN
         YnPPLZR6FKvSgaZ14zpJ1on4p92R3VA2QujCjakXFlgtPN8yqoNb2iIZwgAQdzW2UKSX
         exKw==
X-Gm-Message-State: AOPr4FUsZ9EEIm+NVIXINqc17On3uPwnSpAApg718N051Nr3z5lyHhgGHHgVZYuPIGiOfIHpOa6pgjIMhoa8HA==
X-Received: by 10.28.158.79 with SMTP id h76mr5070942wme.79.1463168555484;
 Fri, 13 May 2016 12:42:35 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Fri, 13 May 2016 12:42:35 -0700 (PDT)
In-Reply-To: <xmqqbn4bdp8f.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294559>

On Thu, May 12, 2016 at 9:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> This is just a small cleanup.
>
> ... which may have been better happened at 09/94.

Ok, I will squash it in 09/94.

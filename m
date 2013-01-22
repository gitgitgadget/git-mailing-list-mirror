From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] unpack-trees: do not abort when overwriting an
 existing file with the same content
Date: Tue, 22 Jan 2013 07:59:01 +0700
Message-ID: <CACsJy8AFKXYkHbUf4aqBpCg+v06oFsvHq_zxQFE4BOCzTDAqtg@mail.gmail.com>
References: <1358594648-26851-1-git-send-email-pclouds@gmail.com>
 <1358768433-26096-1-git-send-email-pclouds@gmail.com> <20130121231515.GD17156@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 22 02:00:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxSDU-0005Et-8W
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 01:59:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752389Ab3AVA7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 19:59:34 -0500
Received: from mail-ob0-f180.google.com ([209.85.214.180]:59400 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633Ab3AVA7c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 19:59:32 -0500
Received: by mail-ob0-f180.google.com with SMTP id wd20so6356358obb.25
        for <git@vger.kernel.org>; Mon, 21 Jan 2013 16:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=tmeTZVvpSpHirx4DxiwHXyEim9ktpjbuteoONT559K4=;
        b=tnfY7GBPFxdhXBbk4PzVBX1bUTYridcx3wh74K47y6gKdTyxHa3/iBVryIw/QH+4pe
         brJT7U0IDQDJWAudGbooip6Gdjjb6NOKqEKHfPl8xO7cMf5KLGUC4OFsb4lsRaa4Clby
         Llomd5tvig1KvTDjFvZFATGZht1zsbU7C+bO1Z6CWD4/7yM0IQXgvO49hJhQVevHWbTf
         7oPfWjVv/+WScGo/R6lmJuc0NHME69LqV+66z9PbRSjbUD3bGd9p/OnucsRMoLweK8q0
         JGwQfjSufNMDGf9JszxuY6nfBemG8q4drnYjiuzAsoR4PF0gdjvXxFaVbHpX7Knqkx2y
         lYKQ==
X-Received: by 10.182.3.144 with SMTP id c16mr15659198obc.42.1358816372296;
 Mon, 21 Jan 2013 16:59:32 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Mon, 21 Jan 2013 16:59:01 -0800 (PST)
In-Reply-To: <20130121231515.GD17156@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214183>

On Tue, Jan 22, 2013 at 6:15 AM, Jeff King <peff@peff.net> wrote:
> Can you elaborate on when this code is triggered?
>
> In the general case, shouldn't we already know the sha1 of what's on
> disk in the index, and be able to just compare the hashes? And if we
> don't, because the entry is start-dirty, should we be updating it
> (possibly earlier, so we do not even get into the "need to write" code
> path) instead of doing this ad-hoc byte comparison?
>
> Confused...

git reset HEAD~10
# blah that was a mistake, undo it
git checkout HEAD@{1}

I hit it a few times, probably not with the exact recipe above though.
-- 
Duy

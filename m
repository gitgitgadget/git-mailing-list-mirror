Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E5371FEAA
	for <e@80x24.org>; Sat, 18 Jun 2016 00:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754991AbcFRA1Z (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 20:27:25 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:38617 "EHLO
	mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754000AbcFRA1Y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jun 2016 20:27:24 -0400
Received: by mail-it0-f52.google.com with SMTP id h190so4861825ith.1
        for <git@vger.kernel.org>; Fri, 17 Jun 2016 17:27:24 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=37949nHc8J6u56vOMgMm11NnTbfQm+YoTV0ZwW4Ul2k=;
        b=g/htYziacSrkZQCVpdn59NIPTJxRnJD2GSvBtbgb5pAp/M6kYvjSz4Tv8RVrLWwvEC
         4++7i26/JzZni4Q5uOAifkBOd31G70jEtIU522MrNtqK+hGb71zsLVbGtDwukqIto33P
         mBjFG7DaOf7SNI9nSQM52rnfeO4Fr2qqOs4KUcJcvjKS72q4+DY1eHGxiu7x7TsMvc2e
         KqshLK3gtXLa5W7gkpzpCKQu4gHhI1jfvMLzWGBb7H8dKq3ftRznpykwFoWqHYUDMm3w
         gH2LqrV+Egk0lG6EP+xt+A/x5CpzXWlLvu3scH77zNJfhaDHPnCEVJtniknBmoyIaIbQ
         hkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=37949nHc8J6u56vOMgMm11NnTbfQm+YoTV0ZwW4Ul2k=;
        b=eWF1SxXGPYYVId/IeWe1pEJO72QDBW8xaSD3q8VeZyguHKC4h6NivjQA5xDkAtpy53
         UY4NwQM3teC9LWH69mEc3HVMg2Ea1DFBlVvl/+wuhMSBxTzrWWylDmNb02TcmD1+AmBU
         4s53Bq4Cnp8g2SEEX7shrXtHMgS6sqyTvHW+M6PaFOsjo4gB/aet0ZlYZRpHf67vnjqU
         cDF7BzRVRV5ax7VyV36NbNpshruyu/ZSLi/Pwa51bvSZBm9/UHw734Sk56p/aHNAoOhV
         byTmeu6qgli0iUXP27nB/gj5WAuVXv/fTx0LlobpoYD1wp0I3vwKvuSGA4rIiKFX218+
         0fBA==
X-Gm-Message-State: ALyK8tLwmDUuLUEUYJvL5XiSpiauPjHis5J9PWEJWaqyxpVHBFW4O0o9iU9ZxoXPy1DXElPaYdHysEfEVwPzvA==
X-Received: by 10.36.130.130 with SMTP id t124mr1764407itd.42.1466209643872;
 Fri, 17 Jun 2016 17:27:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.173.167 with HTTP; Fri, 17 Jun 2016 17:26:54 -0700 (PDT)
In-Reply-To: <xmqq4m8rz9qr.fsf@gitster.mtv.corp.google.com>
References: <1453982183-24124-1-git-send-email-pclouds@gmail.com>
 <1454724190-14063-1-git-send-email-pclouds@gmail.com> <xmqq4m8rz9qr.fsf@gitster.mtv.corp.google.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Sat, 18 Jun 2016 07:26:54 +0700
Message-ID: <CACsJy8CSVvZfwjG+zAEpG6tAWYAWVkrkz4RP32Hrr9O1A_8ZMg@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] Fix icase grep on non-ascii
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Jun 18, 2016 at 6:17 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:
>
>> v6 fixes comments from Ramsay and Eric. Interdiff below.
>
> Another thing I noticed with this is that the non-ascii test breaks
> when run under dash (but passes under bash).  You need to have is_IS
> locale on the system to see the breakage, it seems (which is why I
> didn't see it so far).

Is it a special version, maybe from debian? It works for me on gentoo.

> ~/w/git/temp/t $ equery  --quiet list dash
app-shells/dash-0.5.8.2
> ~/w/git/temp/t $ dash ./t7812-grep-icase-non-ascii.sh
# lib-gettext: Found 'is_IS.utf8' as an is_IS UTF-8 locale
# lib-gettext: Found 'is_IS.iso88591' as an is_IS ISO-8859-1 locale
ok 1 - setup
ok 2 - grep literal string, no -F
ok 3 - grep pcre utf-8 icase
ok 4 - grep pcre utf-8 string with "+"
ok 5 - grep literal string, with -F
ok 6 - grep string with regex, with -F
ok 7 - pickaxe -i on non-ascii
# passed all 7 test(s)
1..7
-- 
Duy

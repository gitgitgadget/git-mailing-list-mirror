From: Nikolay Vladimirov <nikolay@vladimiroff.com>
Subject: Re: [PATCH] buitin_config: return postitive status in get_value
Date: Sat, 28 Jul 2012 16:18:49 +0300
Message-ID: <CAJg5NvdAq_zEx2phVGS4EiUfqMtFJA2Bo=y1d3FJyWXtzMwCTw@mail.gmail.com>
References: <1343475730-18743-1-git-send-email-nikolay@vladimiroff.com>
	<CACsJy8BUU13H1tRfTtUme_7u0Jf0upca31U-VNhXva_0R2MLoQ@mail.gmail.com>
Reply-To: nikolay@vladimiroff.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 15:19:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sv6vg-0000wy-KK
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 15:19:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752444Ab2G1NSv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 09:18:51 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:38152 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731Ab2G1NSu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 09:18:50 -0400
Received: by vbbff1 with SMTP id ff1so3485744vbb.19
        for <git@vger.kernel.org>; Sat, 28 Jul 2012 06:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=XyO7O9Sr5g5krDuCTJ+ttepktNoE43rp7dn6R1GFhZQ=;
        b=KbpgdL12Rrba3XdMrloLo3pyNMnKNTQczDRaGkyLk3JhZ5wyiQxAnIjJ+g/eO2CR/x
         oMGlzXKgSvBMZTalakAYZI4kAb4D/DZ5I6rc1rBzc5oClMwCzIxCx1WLii14HUtZL4gR
         JyYOY+avHqoDv6klT2h8LDz9DkV36iXR/gG5qu1p0nUBw+Eb7ILMkHV869iNl292CVjD
         /ATU1ltyedLDPvm5h0mHEgnTUHZtiGQD7tpVDZRfLUjnArQ9U+1Oi++DvD+qBtaV3e8h
         nCGJ84pkMcmRJi67WLK7HCMcG8ztN6X9kdlch7g+XSuL3ufnz0xGSdUn62gR0Z33BHKT
         8INQ==
Received: by 10.52.95.171 with SMTP id dl11mr4828964vdb.120.1343481529690;
 Sat, 28 Jul 2012 06:18:49 -0700 (PDT)
Received: by 10.220.189.139 with HTTP; Sat, 28 Jul 2012 06:18:49 -0700 (PDT)
In-Reply-To: <CACsJy8BUU13H1tRfTtUme_7u0Jf0upca31U-VNhXva_0R2MLoQ@mail.gmail.com>
X-Google-Sender-Auth: 7xFaDZyr-XYRj5zBqLjnvYj5t4E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202433>

On 28 July 2012 15:59, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> I'm curious. Why is -1 (or 255) wrong? It was introduced in the first
> version of get_value in 4ddba79 (git-config-set: add more options -
> 2005-11-20). Back then it returned -1 when there's regex compile error
> to distinguish with 0 and 1 (but git-config-set.txt in the same commit
> did not get update about exit code). Maybe we should update document
> instead of the code.
> --
> Duy

That sounds great.
But the behavior now seems kind of strange, or maybe I'm missing something:
# git config foobar; echo $?
error: key does not contain a section: foobar
255

# git config foobar.info; echo $?
1

git version 1.7.11.2

I would generally expect the both to behave the same way.

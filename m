From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/4] fsck improvements
Date: Sat, 5 Nov 2011 10:18:43 +0700
Message-ID: <CACsJy8Ch0m5KQ--VWzsmyNq2R-uHsvSYofHP8L+qcvhRrqgoKQ@mail.gmail.com>
References: <1320421670-518-1-git-send-email-pclouds@gmail.com> <7v1utnd8yf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 05 04:32:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMWzP-0001lr-0X
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 04:32:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753359Ab1KEDTR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Nov 2011 23:19:17 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60932 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753058Ab1KEDTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2011 23:19:16 -0400
Received: by bke11 with SMTP id 11so2479084bke.19
        for <git@vger.kernel.org>; Fri, 04 Nov 2011 20:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=tbvVe61l5Q66GyLrJiIh4FKzSAGEfVRUQdrlEouytA8=;
        b=iEcEosQ3XJljL9H/GUCoNmN74OspWvgbQiFw7qpgpweWGfJy2PG2nvVCcc7PXiJiev
         qBxDrbemVR9mGHcFxOXBlcSsWUiD3WdKDEo0eqxQCedBy36uf4arkZGvXYcLs93NZMik
         uG+A+nWTYek2lzQiFBvW5JjYTrP7TEGfBXnUI=
Received: by 10.204.141.211 with SMTP id n19mr13677103bku.71.1320463154309;
 Fri, 04 Nov 2011 20:19:14 -0700 (PDT)
Received: by 10.204.177.79 with HTTP; Fri, 4 Nov 2011 20:18:43 -0700 (PDT)
In-Reply-To: <7v1utnd8yf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184815>

2011/11/5 Junio C Hamano <gitster@pobox.com>:
> I am not sure what purpose patch 2 serves, though. When we find a checksum
> mismatch for an object in a packstream due to a single-bit error, we would
> still be able to salvage other objects in other parts of the pack as long
> as we have a good .idx file, and in such a case, wouldn't it be better if
> we attempted to find as many corrupt objects that we know we cannot
> recover as possible and tell the user about them, so that they can be
> skipped during the recovery process?

It's the inconsistency in that for(;;) loop. If we are going to
salvage as many objects as we could, should we do "continue;" instead
of "break;" when unpack_entry() or check_sha1_signature() fails?
-- 
Duy

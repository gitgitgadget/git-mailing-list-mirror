From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] fast-import: add special mode; copy from parent.
Date: Mon, 22 Dec 2008 04:23:46 +0200
Message-ID: <94a0d4530812211823l78d86e1en8e19872ee7efef23@mail.gmail.com>
References: <1229825502-963-1-git-send-email-felipe.contreras@gmail.com>
	 <20081221220757.GA17355@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Dec 22 03:25:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEaTj-0000Dm-Hh
	for gcvg-git-2@gmane.org; Mon, 22 Dec 2008 03:25:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874AbYLVCXt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2008 21:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751884AbYLVCXt
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 21:23:49 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:14809 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597AbYLVCXs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2008 21:23:48 -0500
Received: by fg-out-1718.google.com with SMTP id 19so710965fgg.17
        for <git@vger.kernel.org>; Sun, 21 Dec 2008 18:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ph8lEAw28pdUEhesPpdJTRysAoGaCVwS8JWKRsDJZM4=;
        b=E+X8bofJ6y+xKNVbNK+0cXj7sCLri8yEc37+fJx9AZD1yretTUJob9HB5OxMlOs9+7
         Fpz0NIOUyMfFVpyOCzfsIUQjeNe3IWn4WibBYrltgM2yXnMR+UVu1pprU96AsP5084w8
         ac+xwDEL3//kN0jAnMMxJJkHP6MnrPej3tITw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=cYRHK7mAeSXQUEgnZGrqWgGBARto7TbrYD275J3UJ8m1HHd3RK/j0Dsg/6WlJTRuMu
         WZUHS5Slg7DdK7NJpGMvIupwfvY2N2J/bLr9Cx0Ws8M+VAtpM9cJcktcR/f6mOGY9S1x
         8DBolvyVWQI4moPwUf3Nk+M+xRx2gcq6BLq5M=
Received: by 10.86.51.10 with SMTP id y10mr3333505fgy.9.1229912626944;
        Sun, 21 Dec 2008 18:23:46 -0800 (PST)
Received: by 10.86.77.17 with HTTP; Sun, 21 Dec 2008 18:23:46 -0800 (PST)
In-Reply-To: <20081221220757.GA17355@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103739>

On Mon, Dec 22, 2008 at 12:07 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> wrote:
>> +     if (!prefixcmp(p, "- ")) {
>> +             mode = 0;
>> +             p += 2;
>
> This part made me wonder, why are we always doing "S_IFREG | mode"
> further down?

My guess is because 0644 and 0755; doing S_IFREG | mode doesn't
achieve anything for the other modes.

I just sent a patch that I hope makes that more visible.

-- 
Felipe Contreras

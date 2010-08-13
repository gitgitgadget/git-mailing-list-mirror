From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Git's tests have depended on Perl since at least 2006
Date: Fri, 13 Aug 2010 23:44:28 +0000
Message-ID: <AANLkTin9k3FerH1exQXMVS7LrJbLraptd5cJzLEh2Mgj@mail.gmail.com>
References: <AANLkTim9aNtFdwM5m-FB_LWX96es2DR_9mU3rGcV4dME@mail.gmail.com>
	<7v4oeyjfnw.fsf@alter.siamese.dyndns.org>
	<AANLkTi=FvAZZsxctJ-sXuQxsMgn15BhKooXjO13CVy6U@mail.gmail.com>
	<7vvd7ehyzy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 14 01:44:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok3va-0004bV-Hz
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 01:44:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756246Ab0HMXoa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Aug 2010 19:44:30 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:42333 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753771Ab0HMXo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Aug 2010 19:44:29 -0400
Received: by yxg6 with SMTP id 6so1167251yxg.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 16:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=N/R3PX92juRGcIIMinKjw3rT8aNF73wDaZtGSd7tglY=;
        b=IMkV0zYuZEKqs8AhGos0wNMzEhZvbEctpSo0NtzDHHd5t2w6F6bQiMjmWdr5KkH2p/
         LiAzrJCB7WxkZBGIDkBNtzxNa64C50ytvw/WjF7BRrUgzn0IiIeLn9RWaXLVEIbNb7up
         99sjmchpJqEfY4biQqtZ5CGSatUtBcn6+ZCcs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=lgSXq2Setqm6p3IIntbfxcJDMUgLjIT0zYhYHWV4voUMN5L9f9yq1CImXuo32vhm5H
         yKOv/iP4/G4XWBuCdjmaXxNVKUzmcZEu7mOIulPXGlS1GgM8pQKt7he/kjPiPmwv8k2m
         500aGNFA0VOyzO/bnjJ/Yx6I4pttboLMH83K8=
Received: by 10.231.15.195 with SMTP id l3mr2125236iba.188.1281743068664; Fri,
 13 Aug 2010 16:44:28 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Fri, 13 Aug 2010 16:44:28 -0700 (PDT)
In-Reply-To: <7vvd7ehyzy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153526>

On Fri, Aug 13, 2010 at 23:30, Junio C Hamano <gitster@pobox.com> wrote:
> I had an impression that your smoker report supports builds on tap harness
> that in turn builds on perl.

It does, but I was considering cases like:

    PATH=/a/limited/test/environment /usr/bin/prove ...

But actually getting rid of the smoker Perl dependency would be easy,
it's just running each test, saving the output to a file and tar-ing
it all up. It'd be very easy to provide a shellscript that did that.

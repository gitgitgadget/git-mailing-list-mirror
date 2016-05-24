From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t7610-mergetool.sh test failure
Date: Tue, 24 May 2016 09:45:25 -0700
Message-ID: <CAPc5daWmhYKNXZJxnZYuCe90vOti7Su-Uab7=9JvvsFYfw1s_Q@mail.gmail.com>
References: <CALR6jEhQrSuVAG9=8AC10Lr776KyVurdTkH8QRHH5GWEMk+wNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Armin Kunaschik <megabreit@googlemail.com>
X-From: git-owner@vger.kernel.org Tue May 24 18:46:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5FT5-0006tQ-CT
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 18:46:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756364AbcEXQpt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 12:45:49 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:36320 "EHLO
	mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756349AbcEXQpr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 12:45:47 -0400
Received: by mail-yw0-f181.google.com with SMTP id x189so21563045ywe.3
        for <git@vger.kernel.org>; Tue, 24 May 2016 09:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=NVgT4IslX7B8AZM0NC6yRgb7pXXSCXGjweAjEo8nygk=;
        b=lr6kFfQKGZZWiL61+ZqlkxrG5BIoAWxvVIiTzcht3csGEXaNwDAUVtSg9E+tOkpwiT
         +Bj6aR+H+l0ZYgfiD4N7BE7TuucbJjcJDCsuPPvAhaBG/TwqlF5FSyGVbRQK+nOgf8Pe
         +Yf8JLueCM3i0lUss9RHg5yrnc0SPX0W21AWxSmBKG8ofMJHOx8R1UvUKunub8UyKz6B
         /Oa8RpIFMu/pcVFlMOli7f3Og6/5jpw0iXNv6uJv14vr30tmyqPXP4uniMLRfNkN5zpY
         XxXzeFoAU6yUsXEvbdgu9ViFpqRC/iUzPCPhWv+Be+D9VgPQm+pfifgh+4fkUX/fNSWV
         UZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=NVgT4IslX7B8AZM0NC6yRgb7pXXSCXGjweAjEo8nygk=;
        b=L8kuikdhjNFQ9mX09wvXG85kyOgW/lhWhR+DxrXenKSe3YEYbWY9qxK0MeA7CBI6A4
         hM40qXJboM91IRBe8fk0htnkcD7R8xgYUXTZx8V5CR4U3M6pGWO/wZ+f6F8+G1P7C5vw
         O0XPPnzvRInEw9c4ywDTo5NdJyPrNZldd4EqJa8b9ZfhQGgP7r+UzzOrFmOgdvuFqSLD
         c9L6Qon2LZoeVulVkpBS6wKPL26gr0zR4kE2fKbnXXO0kXm2vyzt0u0cRZtvHVW1XhsJ
         IO+hn1w3Fn4UAYqi86gNgidHNzguoxaiwZZUJ9VCiiPwqtECI1bQ/miarNCjLcaVgX4S
         vP+w==
X-Gm-Message-State: ALyK8tKHv3kcw0U1cx2VlzwqBHN0k9lWWsPvC+7yn9+IZizqHeNKg7f647P75EJz91BQO9/owtLvpIKl4QG5dQ==
X-Received: by 10.13.219.74 with SMTP id d71mr3123711ywe.293.1464108345296;
 Tue, 24 May 2016 09:45:45 -0700 (PDT)
Received: by 10.13.251.71 with HTTP; Tue, 24 May 2016 09:45:25 -0700 (PDT)
In-Reply-To: <CALR6jEhQrSuVAG9=8AC10Lr776KyVurdTkH8QRHH5GWEMk+wNg@mail.gmail.com>
X-Google-Sender-Auth: n1YwvaTLaHibJB7obUbhZFmyWJc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295502>

On Tue, May 24, 2016 at 9:44 AM, Armin Kunaschik
<megabreit@googlemail.com> wrote:
> t7610-mergetool.sh fails on systems without mktemp.
>
> mktemp is used in git-mergetool.sh and throws an error when it's not available.
> error: mktemp is needed when 'mergetool.writeToTemp' is true
>
> I see 2 options:
> 1. code around it, write an own mktemp, maybe use the test-mktemp as a basis.
> 2. disable the test when mktemp is not available

3. find and install mktemp?

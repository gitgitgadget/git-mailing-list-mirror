From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH next] don't let mailmap provoke use of freed memory
Date: Fri, 15 Oct 2010 05:22:21 +0000
Message-ID: <AANLkTimpN5CAC5UbhC2Kydhu_BMouriQn1d6OL5vt09m@mail.gmail.com>
References: <87tyksd9er.fsf@meyering.net>
	<20101011162153.GG25842@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jim Meyering <jim@meyering.net>, git list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 15 07:22:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6ckP-0004vb-Rm
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 07:22:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755135Ab0JOFWY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Oct 2010 01:22:24 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49186 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753591Ab0JOFWX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Oct 2010 01:22:23 -0400
Received: by fxm4 with SMTP id 4so218171fxm.19
        for <git@vger.kernel.org>; Thu, 14 Oct 2010 22:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=eznnCVPxU6RvvWRQF5NpfsirUYv8f0WU8q5hpWzzX/o=;
        b=sdSNe+M3oBgVPXRhWFyI5M1NCGFdHFdpyZfM6x2m46ZiHom8tN6z5Jyfr1V4pfVnFL
         sLjXNbYzLZ9s0M5M9a/F+oDP07vWy/JEDBDBHjpf5FzDjChb1Z/yXnF+XiBnqlPUOmYP
         OOQM9Q6rqBc3QBbQW/87DBm0NWBDgGAsYEcU8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=tHJKb8vowgs2B5BpyFJDpGyXNKozGspW6mjpkvOg552W/IF3SP6iKH1mchjZw6u1N7
         vUPSO6i/TUydfPvQio1HeQz8sc/uPoosMSXefi1dsXRjpj8UY6bKvNh4VlMyYvzxlJMN
         8BUG0qxg6HgWyqjT422eNsJxO2DV46yNtiMoU=
Received: by 10.103.124.3 with SMTP id b3mr67907mun.76.1287120141826; Thu, 14
 Oct 2010 22:22:21 -0700 (PDT)
Received: by 10.223.119.17 with HTTP; Thu, 14 Oct 2010 22:22:21 -0700 (PDT)
In-Reply-To: <20101011162153.GG25842@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159094>

On Mon, Oct 11, 2010 at 16:21, Jonathan Nieder <jrnieder@gmail.com> wrote:

> Applies to maint, too --- confirmed with the tests below
> (both fail before, pass after).

Both the smokers trast and I run have started to fail on pu with these tests:

    http://smoke.git.nix.is/app/projects/tap_stream/172/260
    http://smoke.git.nix.is/app/projects/tap_stream/170/260

I haven't investigated it. Maybe it's something else.

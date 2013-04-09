From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] t3700 (add): add failing test for add with submodules
Date: Tue, 9 Apr 2013 17:24:43 +0530
Message-ID: <CALkWK0nMQbk3JQ1yX+uv3Eot3qbEvsWGSqVpg8UnoVXP=g_M7A@mail.gmail.com>
References: <CACsJy8BAQUms9sgNh5_VFOx0_9LkobytjDk33VB+U_J-S44o_A@mail.gmail.com>
 <1365416809-4396-1-git-send-email-artagnon@gmail.com> <20130408213006.GD9649@sigill.intra.peff.net>
 <5163FED4.8070403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 13:55:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPX98-0005xF-CH
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 13:55:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935435Ab3DILz0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Apr 2013 07:55:26 -0400
Received: from mail-bk0-f44.google.com ([209.85.214.44]:58582 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932926Ab3DILzZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Apr 2013 07:55:25 -0400
Received: by mail-bk0-f44.google.com with SMTP id jk13so3610510bkc.31
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 04:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=scsrTYoW6sicamLY4ihpthl7uKAsB+1ndF0cYktvfoY=;
        b=UdG6gNVWcUtyB9O5fdjVU3AYQJzyD7vxx7ezfY2gKeDNOSNk7UqtbXEr+jyDcZd8o2
         lKcDf6vqnngM5Gj6IoOT6F6zQRso0yiIvQiJxBQ1nZO8djGVzfq2v/ntwoykGx5GzBiu
         Sjv+g7ZYehkeLm7tq2sb7qouaDRpFd40XYKXM25kXVFBjXShjYEN5s0ZR4YF64jlmW4K
         /+PA3eFSIxqGPibKtZ7kzBiwwBI7w1aHrP5FpYZCJmmiSGhknTT5ryvlfnbO9IOE5KHW
         614jaha0Ej35irE66RfouHskor/vSRO/+L2ytpnEl04i67MqEUXif79zV1KkhXG6Ui7a
         576w==
X-Received: by 10.205.104.138 with SMTP id dm10mr5128392bkc.107.1365508523880;
 Tue, 09 Apr 2013 04:55:23 -0700 (PDT)
Received: by 10.204.37.69 with HTTP; Tue, 9 Apr 2013 04:54:43 -0700 (PDT)
In-Reply-To: <5163FED4.8070403@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220565>

Jakub Nar=C4=99bski wrote:
> Hmmm... I used to do (and still do) such not-recommended thing,
> i.e. keeping git/gitweb/TODO etc. in git/gitweb/.git repository,
> while having git/gitweb/gitweb.perl in git/.git repository.

Why don't you put the gitweb/TODO in a different branch in the git.git
repository?  Why do you feel the need to have two different
repositories tracking different files in the same path?

Just out of curiosity, how does stuff work with your setup?  Does the
worktree gitweb/ belong to your gitweb.git repository or git.git
repository?  How do half the git commands work?  For example, won't
git clean -dfx remove the files tracked by your other repository?
Will a conflicting checkout not stomp files tracked by the other
repository?  How are worktree-rules like .gitignore applied?

> So my (admittedly strange) setup will stop working?

Yes.  I would persuade you not to use such a gross setup; this is not
what git was intended for at all.

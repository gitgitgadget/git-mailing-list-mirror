From: Andy Lutomirski <luto@amacapital.net>
Subject: 'Comma in -to/-cc entry' on valid addresses
Date: Wed, 16 Dec 2015 16:43:28 -0800
Message-ID: <CALCETrWY+n-m_P-0ub4ZPn5yGrr52C8F+wAtJok-cCQmM12d5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 17 01:43:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9Mfi-0005hO-5e
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 01:43:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934236AbbLQAnt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 19:43:49 -0500
Received: from mail-ob0-f181.google.com ([209.85.214.181]:35636 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932118AbbLQAns (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 19:43:48 -0500
Received: by mail-ob0-f181.google.com with SMTP id 18so45825343obc.2
        for <git@vger.kernel.org>; Wed, 16 Dec 2015 16:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=GB4TrYAQM9xeURpmuvAjTISpbHHAA9/EdmpDambyCdk=;
        b=zplxvtSi9+nCHoHmgqBdWZQ8GHFVi0XvDBB4hFcpVLk7li94Mq193GmvUgXQQLNpUn
         AiBJY3zlHo3wMTfCTMhp8NlhU6TOhPsnjOlhr5/Bsjq+awFZpQgKE0MRNfRrA/dJwEdS
         DaNSOt1zo9fjQwR7dB43xugdYklldry/foBuZ+YFUvx42u93+gCSV4Qy9q/yAxyppr2x
         5+rSykykVjkBf7+CjSMD5siq0emoz+D4wXacs3UdU+QHzFc/Wy2SmY1zxibVPwr6gJbJ
         Hq/L+vYXn8VfQ9tr5W/fIhD9Yro/SuUrttkfeh2/ezzaU2dOD+wx0XSbNnjkQYFepf/n
         F4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=GB4TrYAQM9xeURpmuvAjTISpbHHAA9/EdmpDambyCdk=;
        b=SfzYXez5aYFUmOwmcEv/X9KeLWc+rHisF1ty6Cj4HBnmoJIpZOs2iLo/kVnDFyCRcF
         9SuNO+T7E6ex1png1v90vYcEWgu8k2quT4k3jx6WWVejmu6RxqBAa6HIJfJxEMpKSWbW
         ZhVg51JFtRhU+s6UjPLbM8dpddsYylIH0uaqmb/M1jjqI8j0vsRlFj/wxL1Z+sDQka93
         nOX2Fg3S7ciXyqP2v5uH1dckBES62Kxmx0gSgW7AmMgahIlL4/17JAFbXfgjokqrjell
         2VLTojqwD6R7hsgCWcwud2LhD0VqTy/Zq32qWa5kK46IsLEy/hlUTmGHqw1rr2/YGTpb
         xfEw==
X-Gm-Message-State: ALoCoQmqX6/Tg8RXfNwg0PGoLJu/OQbJ4PqalwSpxMpYrxeprJPPxprCDH87uw8DX2Hh8m/36IJXLauWSmrUK5tbl8oPgP1qkQ==
X-Received: by 10.60.101.166 with SMTP id fh6mr36724281oeb.34.1450313027637;
 Wed, 16 Dec 2015 16:43:47 -0800 (PST)
Received: by 10.202.102.231 with HTTP; Wed, 16 Dec 2015 16:43:28 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282629>

$ git send-email --to='"Address, Valid" <somebody@foobarbaz.com>'
Comma in --to entry: "Address, Valid" <somebody@foobarbaz.com>'
$ git --version
git version 2.5.0

This appears to be a recent regression.

For an authority on why the current behavior is wrong, see RFC 2822
section 3.4, which defines mailbox and mailbox-list as well as section
3.2.6, which indicates that a phrase can contain a quoted-string.


--Andy

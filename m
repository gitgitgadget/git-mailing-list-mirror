From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] run-command: do not pass child process data into callbacks
Date: Mon, 29 Feb 2016 13:58:41 -0800
Message-ID: <CAGZ79kb2h=4qeGbQ+42Zkq5wZ6eVu1rNQn=d1R6Rz4YA-q0xwg@mail.gmail.com>
References: <1456783026-3328-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 22:58:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaVq2-0005NL-Qj
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 22:58:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbcB2V6n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 16:58:43 -0500
Received: from mail-ig0-f178.google.com ([209.85.213.178]:35065 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712AbcB2V6m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 16:58:42 -0500
Received: by mail-ig0-f178.google.com with SMTP id hb3so5094269igb.0
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 13:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=UKMPVXzttIV9lF8d9LrwLIytk1rQD7drPBzHmYWejp8=;
        b=iT1TslOlpIkUkyQmTt6ieI8g5vhwAfU/+IAzxDdUKiBtwv/2+6c6XKNWqcIXC4hxQK
         Ilc2fcuiGEX54WUGeNqCsvb+4cVA8CdZY63Z/ZrEdgc62KoJ3d141qmYVp0Zkzj2fdEh
         LBCx73ZyC4DdfQIOqnjA8pO+2Zw4e64YTKl34D8mQZIYRWRFlCJ8e7XcJiRX3lobwhPS
         4w6N7B9qte2MBi+w/GBM62rnXTvz6acEOpNHghvNMCNeuqVyo5+Kuuj1O2lEWnUQ6Rzy
         6mvzuZl3qdVOcoz/3sdaXOlX7wPJgmLOklLQD8/xedy+PezyjKjOY13bmS1ZtD3pSqnq
         JsSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=UKMPVXzttIV9lF8d9LrwLIytk1rQD7drPBzHmYWejp8=;
        b=CYLueXmpmKOnoWVx5KEd40+YwWvKqAqd8J2ocxF7ZbAmYNkG5ycb3TUdYi4U892yF2
         2LqcpcEAbKPVINl6uuuQ0sOfQZnUPu77raJhnANdjXusamaTk7hBe6RzJZlUdt2Kvje0
         ZP3+5xWgXKNZ8MAzy3gIml9Bq+nGShDyVi4RSDK5n3O+EvWqB2lYyVIrd+AYdFJMk4Lx
         HUDsg1FHooQGFhSXYlG/UHwRlEZePaVbna2MHgJSfsqnP3C/46eAZLmhcHe9p59A2is+
         f/qnS6SpTmXy5y5ghBonKJdzhXPHsbZ12TiikyE+2T0AA9Ie1i9jlKrOKrjS4j/wau8O
         PEkA==
X-Gm-Message-State: AD7BkJJTXK4HLv1QMi/KEK9QTJhhSyBlj4wkOsDHRTHJF0eaHC2gpr9kK2iKHXdY6GNcdqckFT9t49CQxatvoEvH
X-Received: by 10.50.112.10 with SMTP id im10mr191111igb.93.1456783121445;
 Mon, 29 Feb 2016 13:58:41 -0800 (PST)
Received: by 10.107.58.6 with HTTP; Mon, 29 Feb 2016 13:58:41 -0800 (PST)
In-Reply-To: <1456783026-3328-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287918>

It applies on 2.8.0-rc0.

(I tried backporting it to 2.7, but realized it is not an issue there)

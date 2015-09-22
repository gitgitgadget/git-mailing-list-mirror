From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 03/13] xread_nonblock: add functionality to read from fds nonblockingly
Date: Tue, 22 Sep 2015 08:59:43 -0700
Message-ID: <xmqqd1xa5tsg.fsf@gitster.mtv.corp.google.com>
References: <1442875159-13027-1-git-send-email-sbeller@google.com>
	<1442875159-13027-4-git-send-email-sbeller@google.com>
	<CA+P7+xp-D-N8W7GL6Rp9F-GHJ5O5jS6_icqB4DQGsiU5Zn5HEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 18:00:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZePyy-0005p4-K3
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 17:59:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933710AbbIVP7r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 11:59:47 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35554 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933700AbbIVP7o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 11:59:44 -0400
Received: by pacfv12 with SMTP id fv12so13017953pac.2
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 08:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=TNQ+qt/5dZao8izk1Kxn3bdjsLZNDS/oxMzPTYpKU10=;
        b=MyCEpky0/auGlQKzjgunSdQrbmyqNkpbGYB0Tg61YkKgN3av/M2/eKBrIvVxn45GDN
         0UDT4ZtwiiRooA/+9PFvJe2o0XWJGcxrtQqcM7fbwlfAPhnos30Yn8DgjIsu5Y/wy25H
         eH5j1RN23a+q71fkdH4eHliQ2tuLiv078VjihhvUcPwIYDEHvdzwqckYlBVl6/V5+lmR
         QkCUhkhJPviefdxte17yEk7IBnQ7lDUAGXcw/Lt8LszrA5Eo0v1LwNG9E2tFPOo1f6BZ
         0XXMfe30BDXjnmMZH9PfUENbIpEoCfB/v4sUz1Cqhzbe8I0/TsusST4jkQaGbXa2l1bi
         72xQ==
X-Received: by 10.66.102.7 with SMTP id fk7mr25668750pab.119.1442937584378;
        Tue, 22 Sep 2015 08:59:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:fd7e:7071:2eda:9c63])
        by smtp.gmail.com with ESMTPSA id e6sm3058445pas.35.2015.09.22.08.59.43
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 22 Sep 2015 08:59:43 -0700 (PDT)
In-Reply-To: <CA+P7+xp-D-N8W7GL6Rp9F-GHJ5O5jS6_icqB4DQGsiU5Zn5HEg@mail.gmail.com>
	(Jacob Keller's message of "Mon, 21 Sep 2015 23:27:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278398>

Jacob Keller <jacob.keller@gmail.com> writes:

> On Mon, Sep 21, 2015 at 3:39 PM, Stefan Beller <sbeller@google.com> wrote:
>
> Maybe change the title to "without blocking" instead of "nonblockingly"?

Both suggestions make sense ;-)

From: Vasily Titskiy <qehgt0@gmail.com>
Subject: [PATCH v1 0/2] Ignore dirty submodule states during stash
Date: Tue, 17 May 2016 03:36:32 +0000
Message-ID: <20160517033632.GA2782@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 05:36:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2VoT-0007YD-5S
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 05:36:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754149AbcEQDgl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 23:36:41 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:34033 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754116AbcEQDgk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 23:36:40 -0400
Received: by mail-yw0-f196.google.com with SMTP id i22so549134ywc.1
        for <git@vger.kernel.org>; Mon, 16 May 2016 20:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=hoj1zhdJijInwAtH2MtqG5QQg/JsM6yEZ0QYNNko/pM=;
        b=dOGFit2qwCtM6+ovuozfE+DxY+jH01WzWz7HKvJ0An8Ya54a1mETtn6dBOe7x2t3vi
         aQtK6tia1nY2d+jOC+hSVxDwLRNcF0Br+E0VZaBytcA9c3VcdHkkoV3iTl3dnmI4Pgh5
         d2pi179vA10I5RX9eBUFNnAzZ19NFE72NO6jyHHUQLLLeyySUOfCVsPSVoX98EfrnHk1
         LUO8Md02iPKhZyw4U+KwoBu5sDqMQvzMaIjQ+25p1sAVKAcd2WwY1fnjsmCCuG0W+n+w
         rSDoTVkqtwFnVfpxTePwK1Itjx1OuLlI5qlLVYIQFV5EU00+ZmMU2gsaMqpzELUMyI71
         R5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=hoj1zhdJijInwAtH2MtqG5QQg/JsM6yEZ0QYNNko/pM=;
        b=laT4WTfrFv0FGAJdegyz6s4zH7RlnwjjJf7dpQQYfAf4FFxXCVfMMfxZoxMYU7cYJh
         OCEv53wysL0sFpDdZK9QoLYt4CSwn5mqXUZzukBvas8fsEYhBtSOrW1ezfSUrec6YYhS
         8nFW9vPb/CG8hr42dh83SU+tsIulsohRrZTBtmnySRr2ozMzrD8m3mCE6pmdexCQv9IL
         Df4l1Hb7KD4Scar8cr4PUAeicSkHBMLg3oRbjvWQgRaWjOaJ/02uKSR1Qa4/w+J20bx8
         Alk8r6IcoZSNGb0rcC5cXV0H1A5+YdzYLiG7TAXQgAgrhIABSR9VB5IxFEBN7kBx1ZVp
         aYOQ==
X-Gm-Message-State: AOPr4FX++lh8vPgx3fx2aAT04vVGxKOT0mfV3HOO7b3i0o35yOMqZHeHlCAQ3cfIA93tfw==
X-Received: by 10.13.231.5 with SMTP id q5mr18121626ywe.6.1463456194708;
        Mon, 16 May 2016 20:36:34 -0700 (PDT)
Received: from gmail.com ([2600:3c02::f03c:91ff:fe96:da77])
        by smtp.gmail.com with ESMTPSA id i67sm485729ywf.34.2016.05.16.20.36.34
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 May 2016 20:36:34 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294844>

Impoved description + added test

 git-stash.sh     |  2 +-
 t/t3903-stash.sh | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletion(-)

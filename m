From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH v2 0/8] completion: compgen/compadd cleanups
Date: Sun, 18 Nov 2012 11:56:45 +0100
Message-ID: <1353236213-13471-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20Gustavsson?= <bgustavsson@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Robert Zeh <robert.a.zeh@gmail.com>,
	Peter van der Does <peter@avirtualhome.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 18 11:57:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ta2Z5-0007lt-Uq
	for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 11:57:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440Ab2KRK5K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2012 05:57:10 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:38308 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239Ab2KRK5J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2012 05:57:09 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so1599953bkw.19
        for <git@vger.kernel.org>; Sun, 18 Nov 2012 02:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=M3h0OA1z7wGXZTE+MN627ktwJl63Ma8Y6cEs+/TaUEA=;
        b=HEYVJqiiExbr7m9L65OghAv9dlMdCTuyhPRnm0EtoCUW3QjMLJe18afirxm+WBoXhO
         j6BFdlwC/84sUqkErpxNDDbvjWW2h+l4OrPKi+oUs1WE9+6RRdmntRRsLvkN0ZxQMs3T
         oG23HDD2T/H78hU07srK0aoubHNeVZYBAQ0Y1NLyPO0YdqdXbICltV2ha5THGW8Jt0aq
         fyB2GVsfPip7UwcIaNjPVMjjKR9R0HAux03v3Yy+Gw3+cED1BVOLc1je8QcWmJyRlsHC
         FrV/f3/qLSEdLCRI1Rl/RVHVpM5vnIwk0obzOXl00SYQkjRE270uw/nj6B2HHiW1KvKQ
         1NIw==
Received: by 10.204.12.220 with SMTP id y28mr3916059bky.112.1353236228353;
        Sun, 18 Nov 2012 02:57:08 -0800 (PST)
Received: from localhost (ip-109-43-0-81.web.vodafone.de. [109.43.0.81])
        by mx.google.com with ESMTPS id u3sm2896326bkw.9.2012.11.18.02.57.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Nov 2012 02:57:07 -0800 (PST)
X-Mailer: git-send-email 1.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210013>

Hi,

These were hinted by SZEDER, so I went ahead and implemented the changes trying
to keep in mind the new zsh completion werapper. The resulting code should be
more efficient, and a known breakage is fixed.

The first two patches are transplanted from another patch series which most
likely is not going to use them.

I also borrowed the tests from another patch series from SZEDER, but they are
not meant to be applied through this series.

SZEDER implemented some of this, but I prefer my version of the patches.

Felipe Contreras (8):
  completion: trivial test improvement
  completion: get rid of empty COMPREPLY assignments
  completion: add new __gitcompadd helper
  tmp: completion: add SZEDER's tests
  completion: get rid of compgen
  tmp: completion: mark SZEDER's tests as fixed
  completion: get rid of __gitcomp_1
  completion: small optimization

 contrib/completion/git-completion.bash | 77 ++++++++++++----------------------
 t/t9902-completion.sh                  | 66 ++++++++++++++++++++++++++++-
 2 files changed, 91 insertions(+), 52 deletions(-)

-- 
1.8.0

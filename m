From: Michal Nazarewicz <mpn@google.com>
Subject: [PATCHv2 0/5] Make git-send-email use git-credential
Date: Thu,  7 Feb 2013 15:01:16 +0100
Message-ID: <cover.1360242782.git.mina86@mina86.com>
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Feb 07 15:01:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3S31-0005Hw-Ez
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 15:01:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758673Ab3BGOBe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 09:01:34 -0500
Received: from mail-ea0-f179.google.com ([209.85.215.179]:37854 "EHLO
	mail-ea0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758667Ab3BGOBd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 09:01:33 -0500
Received: by mail-ea0-f179.google.com with SMTP id d12so1084615eaa.38
        for <git@vger.kernel.org>; Thu, 07 Feb 2013 06:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=1qk2HXwAOJOG2i2bZsZ8piatWihnZeTPs0FKNoZb1x4=;
        b=CdwMRwFEuQzt+8hpG3oTBekSL7LEripkUn7cw3NKKI9m2ELuT5K3Fo0Rqr6km7s9Z0
         /P4JKJDGOmtsYzBOsGrU/vsVYvI44NysRH3BlPZ4QWrPLTtm48auXOyr6LvGbGn1CxiM
         3x/5Eo/uiwyePBp+PsoP+QKTpETuJt85KswTL/RlQg55zoUYkLgzCiKYLc4eDJY/UAJ+
         3QAQLDYcRbIfj/Y2BSbpIJWGQbExUg3pwrfdANK4zkhTROJrEMd++QcnM3XTyAFRgLIq
         KuNQompDBDbS7qFbNuj/vUPOxQkXVbaQHyqd+5xRVDZe3Jay7pCp0fIhKgOMHdgGoG3T
         do0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer
         :x-gm-message-state;
        bh=1qk2HXwAOJOG2i2bZsZ8piatWihnZeTPs0FKNoZb1x4=;
        b=EMQ3b4podoo4IdHOsyBvnycLpz3XEXuC7ONCRoBV5SgKNQsqS4ysh6Tqdr5TLGCMZz
         LoF6fLj/D0+9Soxb1P62sQLylYXVpRpHfA+tjiN3HVGerVvWSpKYRr1V/i9WE/im0nXg
         DukjPBdJ68QoA88pdDcScKCw1pH4RTxzME7GGUZR9qxFv68YSiXBJcLs0Fga/ZewYWUm
         lH9CuZZswaKZu6FxE3qlzMQxrfUDhOmC9JQEzAxTPX+0RcQAsfysiasJOphRiJbjnC83
         alarAvXWcuLuUMXtTVtGEFK1hQPG4WOtix+1oMMtCG2s0/sePyfKzLNwihqp1y4QH56i
         ANHQ==
X-Received: by 10.14.5.12 with SMTP id 12mr4294354eek.36.1360245692166;
        Thu, 07 Feb 2013 06:01:32 -0800 (PST)
Received: from mpn-glaptop.corp.google.com ([2620:0:105f:5:bdef:84b9:750e:31d0])
        by mx.google.com with ESMTPS id f6sm42214479eeo.7.2013.02.07.06.01.30
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 07 Feb 2013 06:01:31 -0800 (PST)
X-Mailer: git-send-email 1.8.1.2.550.g0b3c9b6
X-Gm-Message-State: ALoCoQmuKyipYj3Z4kN4QB1qM4EL1p5HX4QFaiimSKw1UZ1xkugUoGVvd6DzZXhtTYe20Vm1e8+YtRJCFRe83D6drh/KbCb0tYUETmlTQI6fVBExf8Ec2jVlKW4AByyaEdBsEp7UAEyZ+Mmow28qNbaGnpcGK8DwLHhx3y6pFh5Rleo8ExfCxHaDMeVoIJNOTHFPKAhijuXN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215692>

From: Michal Nazarewicz <mina86@mina86.com>

Minor fixes as suggested in emails.

Michal Nazarewicz (5):
  Git.pm: allow command_close_bidi_pipe to be called as method
  Git.pm: fix example in command_close_bidi_pipe documentation
  Git.pm: allow pipes to be closed prior to calling
    command_close_bidi_pipe
  Git.pm: add interface for git credential command
  git-send-email: use git credential to obtain password

 Documentation/git-send-email.txt |   4 +-
 git-send-email.perl              |  59 ++++++++++--------
 perl/Git.pm                      | 129 +++++++++++++++++++++++++++++++++++++--
 3 files changed, 161 insertions(+), 31 deletions(-)

-- 
1.8.1.2.549.g1d13f9f

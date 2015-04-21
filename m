From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] RFC/Add documentation for version protocol 2
Date: Tue, 21 Apr 2015 16:19:02 -0700
Message-ID: <1429658342-5295-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, mfick@codeaurora.org, pclouds@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 22 01:19:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkhRg-0008D5-4H
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 01:19:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964912AbbDUXTI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 19:19:08 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:34900 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933362AbbDUXTG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2015 19:19:06 -0400
Received: by igbyr2 with SMTP id yr2so100293689igb.0
        for <git@vger.kernel.org>; Tue, 21 Apr 2015 16:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=RY8jz6ebbN9QGEV4MhfipTaCUnBIwcXG4+BGLnVq+no=;
        b=k7bG/x1TqvhIcYMuWfOopdBfurieobsvCBnNP29Iv+qFryYwjpUutlt66jncwO0nGq
         Vzvvxql7qvnPnXP8Q+YatvgpyeKw1SqYhEnzXQOUctSnfLcuaFwlDA4DKiGcs37wPGt3
         1UJjoPORD1SPOhd4+pJXzbqGzlnUWXQX58FQ8F3s+FrRs0ZyLpGnHDO1iek3KYZn2wp2
         vPBu41fbTdzEwXb7xrrAj8KUnVwVC2P+uMixLWdnNtN7VlaxCLhEYyFawAcUD8bBlA9u
         RzQFN93CN1iJxdiI1hmeAuddzTsV5Q1K+YnZGmCIT9di8IhJWX+XX9A6U0BEk59LII35
         V2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RY8jz6ebbN9QGEV4MhfipTaCUnBIwcXG4+BGLnVq+no=;
        b=BB6nZtJw26/Uc7fy450SkpC6PLuJ1wNZIEwJaGOHjtsHV9cjdSKT1t+Y5Ey6mMBwyn
         p1d+wQm+JvQO1egkAmuePA9eVLZxIPB6VJThEuHMEF3cMOAYtdp7WZkXKEwpyuskLw+N
         xyaAzAOBG5zfgxqlK/MdD3uidbUbTK3uMsPvBmkNC5h2amcQpnUofFpIkpQpDaS6WWuV
         Q9EKB+lRzs41rvGMzZ79Ygi7XCCQOPwCgIp2vM9Ap1oXqhPTwldOXLkSmFQdvKq+c9N3
         yVMc5M0ozD6lxQb1eXh1Lnc87HTZUHLbGCOvzC4ISVfy3Qc34zPjWrgvMjJRhq6dGXDY
         /gOg==
X-Gm-Message-State: ALoCoQkI+LPoevgQ3mfeEw4CDg6hgrm0Cr1Bpm0ubEx3p8cbWtuufW1MPI03pZj1y3wBCsBfsiBb
X-Received: by 10.50.29.110 with SMTP id j14mr642820igh.4.1429658345133;
        Tue, 21 Apr 2015 16:19:05 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:4566:60b8:9788:169f])
        by mx.google.com with ESMTPSA id s85sm1980890ioe.28.2015.04.21.16.19.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 21 Apr 2015 16:19:04 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc2.5.g4c2045b.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267572>

This adds the design document for protocol version 2.
It's better to rewrite the design document instead of trying to
squash it into the existing pack-protocol.txt and then differentiating
between version 1 and 2 all the time.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
  
 As we discussed at Git Merge in Paris, I'd just start out implementing the new
 protocol "to deliver something you can play around with". Unfortunately I
 did not come up with an implementation straight away, but I think we should be
 coming to a consensus on the rough design at first. If there are no objections
 in the design I'll go for implementation.

 Documentation/technical/pack-protocol-2.txt | 88 +++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 Documentation/technical/pack-protocol-2.txt

diff --git a/Documentation/technical/pack-protocol-2.txt b/Documentation/technical/pack-protocol-2.txt
new file mode 100644
index 0000000..36ddf3e
--- /dev/null
+++ b/Documentation/technical/pack-protocol-2.txt
@@ -0,0 +1,88 @@
+Packfile transfer protocols version 2
+=====================================
+
+This document describes an updated protocol to transfer packs over ssh://,
+git:// and file:// links. All three transports (ssh, git, file) use the same
+protocol to transfer data. This document describes the version 2 of the pack
+file protocol, which is incompatible with the previous pack protocol.
+
+The http:// transport is not yet thought about in this phase of the protocol
+design.
+
+As this protocol is introduced rather late in the game, just after Gits 10th
+anniversary, a client SHOULD NOT assume a server speaks protocol version 2
+unless the server advertised protocol in a prior exchange.
+
+General structure
+=================
+
+There are four phases involved in the protocol, which are described below:
+
+1) capability negotiation
+2) goal annoncement
+3) reference advertisement
+4) pack transfer
+
+
+1) Capability negotiation
+-------------------------
+
+In this phase both client and server send their capabilities to the other side
+using the following protocol:
+
+---
+list-of-capabilities = *capability flush-pkt
+capability           =  PKT-LINE(1*(LC_ALPHA / DIGIT / "-" / "_"))
+----
+
+The capabilities itself are described in protocol-capabilities.txt
+Sending the capabilities to the other side MAY happen concurrently or
+one after another. There is no order who sends first.
+
+Note for developers:
+The amount of data SHOULD be kept very small. Future extensions to the protocol
+SHOULD only add a capability flag to this phase, adding possible data
+transfers into later phases. This ensures the protocol is extendable over
+time without having to spent to send huge chunks of data in the first phase.
+If both sides agree on a certain feature being used, it is easy to introduce more
+phases at any convenieant point after the phase 1 is finished.
+
+Notes as a design rationale:
+I thought about caching
+https://www.ll.mit.edu/HPEC/agendas/proc04/invited/patterson_keynote.pdf
+
+2) Goal annoncement
+-------------------
+
+The goal of this phase is for the client to tell the server what
+outcome it expects from this communication, such as pushing or
+pulling data from the server.
+
+---
+list-of-goals    = *goal
+goal             = PKT-LINE(action-line)
+action-line      = action *(SP action-parameter)
+action           = "noop" / "ls-remote" / "fetch" / "push" / "fetch-shallow"
+action-parameter = parameter-key *("=" parameter-value)
+parameter-key    = 1*(LC_ALPHA / DIGIT / "-" / "_")
+---
+
+You MAY specify multiple goals such as fetch and push or fetch-shallow.
+You MAY also specify the same goal multiple times with different parameters.
+You MUST omit goals which are part of other goals, such as ls-remote being part
+of fetch.
+
+The action parameter is dependant on the action itself. For now only fetch and push
+take the parameter "mode", whose only allowed value is "version1".
+
+Note:
+The parameters should follow a key=value pattern, where the value can consist of
+arbitrary characters. Having such a pattern would allow us to easily add a new
+capability for narrow clones (e.g. "fetch-narrow=Documentation/*,.git*,.mailmap"
+to fetch only the Documentation and .gitignore/attributes)
+
+3) Ref advertisement
+--------------------
+3) and 4) are highly dependant on the mode for fetch and push. As currently
+only mode "version1" is supported, the these phases follow the ref advertisement
+in pack protocol version 1 without capabilities on the first line of the refs.
-- 
2.4.0.rc2.5.g4c2045b.dirty

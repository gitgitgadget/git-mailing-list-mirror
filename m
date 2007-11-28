From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Rollback of git commands
Date: Tue, 27 Nov 2007 20:49:20 -0500
Message-ID: <9e4733910711271749q1b96bfe9i60e43619c89234b9@mail.gmail.com>
References: <9e4733910711271523p3be94010jac9c79e6b95f010d@mail.gmail.com>
	 <7vmyszb39s.fsf@gitster.siamese.dyndns.org>
	 <9e4733910711271733r6f280618pbb14095aebba3309@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 12:47:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IxKxb-0004vb-RM
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 12:20:07 +0100
Received: from mail-mx9.uio.no ([129.240.10.39])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxC99-0005kS-0U
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 02:55:27 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx9.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxC82-0004pq-JI
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 02:54:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759942AbXK1BtX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 20:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759883AbXK1BtW
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 20:49:22 -0500
Received: from wa-out-1112.google.com ([209.85.146.182]:2294 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759830AbXK1BtU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 20:49:20 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1532075wah
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 17:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=NyEWdUpirwcW2DlvqeoC6qE+BrEF+Ra6rcS/upzA+zI=;
        b=T2YDHsRbYceLuC7LWnDnYbhenoh171uVsbiM+bqPrCkI+ZyNQX4Aerlo9GJtinlA7kTLetE+D7oZ4uxZ3u/iJOr+0eX7Rur9VtzsVwzM1tTNQXmKUxquIteGjNv0F9VDvb7H0ElvlqshJO2k02sXLgM5y4Avf2MaNTGdK8B3uy0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fVXED/5omMcWUU8E13kBl2sUFdVHHiagWD+TkFx4ETy10LqhWB9lm6FOrJYjlM4Nj5yJpnVxMOv4bwAqBrOAioQYjLXoT2W1oXd5aXWfly4IQheMPvOCfFGV0pTxizgmXiLiIO/UtMFto/Obh/hJFynF4ebVJcV1D7xq4s6NF70=
Received: by 10.114.77.1 with SMTP id z1mr82650waa.1196214560386;
        Tue, 27 Nov 2007 17:49:20 -0800 (PST)
Received: by 10.114.160.3 with HTTP; Tue, 27 Nov 2007 17:49:20 -0800 (PST)
In-Reply-To: <9e4733910711271733r6f280618pbb14095aebba3309@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-ClamAV-Virus: No
X-UiO-Spam-info: not spam, SpamAssassin (score=-4.9, required=5.0, autolearn=disabled, AWL=2.098,RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3)
X-UiO-Scanned: 294FFA42128EDCCE35D7AF207A6F72AFC970990B
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -48 maxlevel 200 minaction 2 bait 0 mail/h: 72 total 723606 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66289>

Rollback is too strong of name for this. Checkpoints would be better.
The idea is to record the total system state at convenient moments and
then allow moving back to the checkpointed state. The object store
supports this, but the rest of the state in .git/* isn't being
recorded.

-- 
Jon Smirl
jonsmirl@gmail.com

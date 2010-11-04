From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH 1/2] Use git_open_noatime when accessing pack data
Date: Wed, 3 Nov 2010 22:23:26 -0700
Message-ID: <95C8862A-11A8-436C-AAD9-C231DA2BC3E4@sb.org>
References: <1288652061-19614-1-git-send-email-spearce@spearce.org> <1288652061-19614-2-git-send-email-spearce@spearce.org> <7v8w1axrnp.fsf@alter.siamese.dyndns.org> <20101103174148.GB13377@burratino> <7vvd4ew687.fsf@alter.siamese.dyndns.org> <20101104050437.GB15018@burratino>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 04 06:23:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDsIP-0000Vt-QW
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 06:23:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754031Ab0KDFXa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 01:23:30 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:49277 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022Ab0KDFX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 01:23:28 -0400
Received: by pzk28 with SMTP id 28so96837pzk.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 22:23:28 -0700 (PDT)
Received: by 10.142.213.10 with SMTP id l10mr207085wfg.199.1288848208621;
        Wed, 03 Nov 2010 22:23:28 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id q13sm14807608wfc.17.2010.11.03.22.23.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Nov 2010 22:23:27 -0700 (PDT)
In-Reply-To: <20101104050437.GB15018@burratino>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160693>

On Nov 3, 2010, at 10:04 PM, Jonathan Nieder wrote:

> I guess I should put it another way.  What if anything does readonly
> have to do with O_NOATIME?  Why shouldn't we always use O_NOATIME?
> Why should the operating system provide atime at all?

atime is useful for user-level files that are opened or modified as a
direct result of actions the user took. I don't think a took like git
has any reason to ever want to touch atime.

-Kevin Ballard

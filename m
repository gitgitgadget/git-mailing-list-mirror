From: "Todd A. Jacobs" <tjacobs@si2services.com>
Subject: Bug report: %h for abbreviated hashes broken after 1.7.1
Date: Tue, 24 Aug 2010 22:54:35 -0400
Message-ID: <AANLkTinR6_DFD_MbFRbtyJKPhZG1Os0ro=4TcC2h_xZo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 25 04:55:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo69c-0002Lk-O5
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 04:55:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756507Ab0HYCzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 22:55:52 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49970 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660Ab0HYCzv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 22:55:51 -0400
Received: by wwb34 with SMTP id 34so216708wwb.1
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 19:55:29 -0700 (PDT)
Received: by 10.216.179.137 with SMTP id h9mr6786880wem.39.1282704875413; Tue,
 24 Aug 2010 19:54:35 -0700 (PDT)
Received: by 10.216.229.164 with HTTP; Tue, 24 Aug 2010 19:54:35 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154402>

I have the following string in a file:

    $Format:Git ID: (%h) %ci$

which is being expanded by git-archive. In git 1.7.1, this properly expands to:

    Git ID: (58b31cf) 2010-08-24 14:00:00 -0400

but in 1.7.1.1 and 1.7.2.2 I am getting:

    Git ID: (58b31cf99592ca39b1d6b0f08f71674a7ed0ffbd) 2010-08-24 14:00:00 -0400

Checking 'man git-log' still says:

    %h: abbreviated commit hash

so this seems to be some sort of regression in how pretty formats are
being expanded. It looks like commit
35039ced9296786bc0971bf5385c0d6f6ea5ea1e was supposed to fix this, but
it apparently still isn't working in the latest tarballs available on
kernel.org.

Can someone please look into this?

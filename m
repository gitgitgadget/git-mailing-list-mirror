From: Tay Ray Chuan <rctay89@gmail.com>
Subject: counting the number of connections?
Date: Sat, 28 Feb 2009 14:44:31 +0800
Message-ID: <be6fef0d0902272244q468b1fa4sacdc15afa9a65f15@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 28 07:46:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdIxW-0003Uo-LC
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 07:46:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbZB1Goe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2009 01:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbZB1Goe
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 01:44:34 -0500
Received: from wa-out-1112.google.com ([209.85.146.179]:3604 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942AbZB1God (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2009 01:44:33 -0500
Received: by wa-out-1112.google.com with SMTP id v33so788686wah.21
        for <git@vger.kernel.org>; Fri, 27 Feb 2009 22:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=fdT/epHhG3BtJ33NyzEdsmR8tRBeXr3s+j7iYSkz3xY=;
        b=N/IfI2xe3OCic0/ogo+TYpFxrhwNyI0gADwXenLmYKbJjaXbSuAW17uLKZtsBhDTwJ
         KPLdlwIKwvg1OPGbjO81fW/sLvh/gByikOASW4Fn90xXUhAVAcjcr7nVv0XDq0Ih80zg
         T0wNSkTzz/inJwiQWK4gqJxgZyV5d2Fi24Dac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=q/zq8CUJgR6sIDXKEPA62jeG1qFgWUjEPoZsYOI8+9ZSLalO2+OqtIWYK1v04nsr1N
         YvBGEIPiZ8eqNgHMGTpIl34ykQBkQRPJhgv5paUW5if2zdV2O+NOQdDEO4LniBol2kto
         Pw+EIXg8REQi+9D+WyFEiZ3i7ERVJ+0j1N8do=
Received: by 10.114.124.1 with SMTP id w1mr1550101wac.13.1235803471109; Fri, 
	27 Feb 2009 22:44:31 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111751>

Hi,

some time ago I noticed curl doesn't remember your credentials (apart
from those it can get from ~/.netrc), and very recently there was an
thread on repeated prompting for credentials while pushing to https.

I've written a simple patch series, which allows git to play nice
without curl_multi. That is, git uses a single persistent connection
throughout.

However, I'm at a loss at how to test for this. How does one count the
number of connections made during the lifespan of a program's
execution? So far, I've been relying on my firewall log (Comodo on
windows). Perhaps there a more operating system/software-agnostic
method to do this?

-- 
Cheers,
Ray Chuan

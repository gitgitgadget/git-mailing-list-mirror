From: Bobby Eickhoff <beickhoff@gmail.com>
Subject: git-cvsimport is setting incorrect timestamps in the master reflog
Date: Tue, 21 Dec 2010 09:18:23 -0500
Message-ID: <AANLkTik1w73skjP=Exj9po2nWbgemqx=hBWzgBFeXP4d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 21 15:18:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PV32s-0000ua-RU
	for gcvg-git-2@lo.gmane.org; Tue, 21 Dec 2010 15:18:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751927Ab0LUOSY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Dec 2010 09:18:24 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:53066 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237Ab0LUOSY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Dec 2010 09:18:24 -0500
Received: by qwa26 with SMTP id 26so4023667qwa.19
        for <git@vger.kernel.org>; Tue, 21 Dec 2010 06:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=MhP6yqq1wvsQWgIf2nt8w47fgBRO64BVjXrxOuImVhM=;
        b=jJvGvYQhHde0TdQLb5esFAbYj0CXoZRrZAA0d3Oo3ADCfeKAdLCfYvCBQB+HRcAgZ5
         kKVWUasWXb9o3dEFT7IO48mtF0lZSduC4ARn+BngK9kd6J06g6I+fpoJRcHoS7MQbYuz
         0i7dcNMex16gkNrclLFHZPIvbvqAD825mcdf0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=rMLklB4ZhLU2S5SCAaeFwkBmmprOFA/Q+mDae3hMCO11AGMjNo8Rk1YtCEKMNM4WHc
         1jiuJasnLHJmoz+xD7zD6Lue918XMG3ZNR00ERXQC8bhgVqiEfcOtvP+dneQUSVxH9CH
         lzmnl7H6Znxwtjn+ea17mwS//HGagQodNZXuM=
Received: by 10.224.181.141 with SMTP id by13mr5355549qab.98.1292941103326;
 Tue, 21 Dec 2010 06:18:23 -0800 (PST)
Received: by 10.220.202.12 with HTTP; Tue, 21 Dec 2010 06:18:23 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164035>

When I run git-cvsimport, the timestamps that it shows in the reflog
for refs/heads/master do not reflect the actual times that the ref is
updated but rather reflect commit times in CVS.

In fact, it looks as if the reflog timestamp is always set to the
timestamp of the last patch appearing in the cvsps cache, regardless
of what branch that patch affects and regardless of when the actual
update to the local "master" ref took place.

Until yesterday, I was using git version 1.7.2.3, and as of yesterday
I upgraded to git version 1.7.3.3, which is currently the highest
version offered by Cygwin.  Both versions exhibit this behavior.

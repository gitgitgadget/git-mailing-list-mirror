From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Bugs ignoring submodules?
Date: Sun, 15 Nov 2009 16:57:22 +0200
Message-ID: <94a0d4530911150657y6692a531hed99230c0d9dc315@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 15 15:57:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9gXj-0003NK-SS
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 15:57:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146AbZKOO5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 09:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751771AbZKOO5R
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 09:57:17 -0500
Received: from mail-iw0-f178.google.com ([209.85.223.178]:57268 "EHLO
	mail-iw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752AbZKOO5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 09:57:16 -0500
Received: by iwn8 with SMTP id 8so3682417iwn.33
        for <git@vger.kernel.org>; Sun, 15 Nov 2009 06:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=fi3SkZMlGUkykF0RA/8bbCZlmf6DF7fRRg/tryElth8=;
        b=ICfl8nKE4mDsZWAh/sBVYSDW9Mmb4lmibmda2y8tTM2sCjH5ViniHVKgkjjdxrlKBa
         yVQQZiP6D7V0twU5REfxfXVl1/gSFH5U+sq0h8YGHgP8YWFgFxTB0A444ItuJ7H3X4Qg
         EtWB1qsgPIoreQ1cEa5fpdstiN7BtO6eGcMzA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=FTSN6SodrgnKR5a7T271jVVjyyflejSFdUun+rX5mVYWi5NFY8ua3Uxb0Me7E1gATF
         9Gapo8s9968EWh2FBG4UdL99/k3qdyIeEsspZf5/Kwpb3PBKNiri5QioTHlCnUIMRzZJ
         R+caYL11zevH74EmLqjpcaQosJvSQ79hdtJMA=
Received: by 10.231.73.131 with SMTP id q3mr3652213ibj.6.1258297042093; Sun, 
	15 Nov 2009 06:57:22 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132944>

Hi,

I'm trying to format patches ignoring changes in the submodules, and
so far everything I've tried is failing, which I think points to
multiple bugs. I'm using 1.6.5.2.

First I tried:
% git format-patch --ignore-submodules

That ignores the submodules, all right, but still generates an empty
patch, just like 'git log' shows no diff.

Then I tried:
% git log <committish> -- $(git ls-files -x <submodule>)

But the submodule is still listed:
% git ls-files --exclude=common | grep ^common
common

These are bugs, right? Is there some other recommendation?

-- 
Felipe Contreras

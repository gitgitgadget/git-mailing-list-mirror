From: redstun <redstun@gmail.com>
Subject: [idea] separate .git dir and the working tree
Date: Sat, 5 Feb 2011 10:53:58 +0800
Message-ID: <AANLkTik4MjnpOzPdGy7ZDiH0in4e1DpjrhQFOHjUiEEE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 05 03:54:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlYIP-0002h6-Pi
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 03:54:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752815Ab1BECyk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Feb 2011 21:54:40 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38548 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752764Ab1BECyj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Feb 2011 21:54:39 -0500
Received: by fxm20 with SMTP id 20so3089099fxm.19
        for <git@vger.kernel.org>; Fri, 04 Feb 2011 18:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=VinA8i9eji9LiOfDhAiPRhutg8CYzwZaPsIoTqx6aMk=;
        b=nneq31xvzNkO75Q2zqWxtw0eQT71+SEtop3nhOxP5EtFua5PbGzslXWZ7Nnpj5x7D3
         Ien6LyUwLBWelP+d/HbI+o7Oax1osZwwoQFdiakQ548jMHGP4fGkyjrEnYoA0qonjkVR
         uCI7KEpDgEg9blQ9NaTkxI/QZU3F9Nmyu/e8s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=CJG3UcF0EPCuoEMPksgs4hra2aUfOWxHYJyOxuM+g86XTwPyJRFO/o1ouzyaKdFtkD
         O9XR3LHcbWdLRryLXWp2GBgMvggn8GiMTL+whWKr0TPv8cCFWbfvrzlfQlQgt0JjB8pF
         DXoWHwCfo8ESL0KGb+kJ5TezcSFKiyKsOj3ik=
Received: by 10.102.244.3 with SMTP id r3mr8338061muh.128.1296874478381; Fri,
 04 Feb 2011 18:54:38 -0800 (PST)
Received: by 10.103.212.19 with HTTP; Fri, 4 Feb 2011 18:53:58 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166071>

First please shout if this is a known feature :-)

I think separating the .git directory from its working tree could
increase the safety of the data to one more level higher.

We might have a git variable set to specify (a shared place) where to
put the .git directories (or the data inside it), then use
"/path/to/working/tree" as (or the seed to calculate) a hash key to
map from the (.git directory in the) shared place to the working tree
directory.

Or we may have just a few data (that can be re-created) stored in the
.git directory along with the working tree, and most of the revision
history stored in the shared place.

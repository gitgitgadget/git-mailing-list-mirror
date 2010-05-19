From: Pedro Belo <pedrobelo@gmail.com>
Subject: git 1.7.1 freezing during http transport with sideband
Date: Tue, 18 May 2010 18:37:55 -0700
Message-ID: <AANLkTilHslSYFhxdyebhbatVmA98ZtoPgFDdqLQhLJNH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 19 03:38:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEYET-0006LE-Pb
	for gcvg-git-2@lo.gmane.org; Wed, 19 May 2010 03:38:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754749Ab0ESBh4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 May 2010 21:37:56 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:57955 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754434Ab0ESBh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 May 2010 21:37:56 -0400
Received: by vws9 with SMTP id 9so3370092vws.19
        for <git@vger.kernel.org>; Tue, 18 May 2010 18:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=knJQ2O2bpTaGAX7pUuUwxDjJivqf68Zx2YtKrEKPO7E=;
        b=fFfcaiUKWrwrRZLEYLUnTiUJQ6lUQp9Ja3XbwXkIgQG1qdFq8R9aCn19Se5tYWY7gF
         IIQCcQdy59ujS1OIhsWtIYP++MEa9U1tTmai2BI00HPws/HCgQIQAuNh6kmc+y4CHIgG
         RmLtNklQeV89jLb4SlvDZmI5vWFlxkMAA2i2k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=DGL+pWBB9CPWP/tI6lvWQm+PHA1DLAGPMrvSzZGbp2HReAVR8jBfPErtxb9yGQvqpY
         iiK5+MLx5GM6IEcBhDIcseEj06WTb20vfY8/sKgBBj0LJfa1nuEoWNaqbIA5qlsEo5oV
         qDHxT9HsnL4tI7ZlnAZr1d1AmECkip3vgnL5k=
Received: by 10.220.61.142 with SMTP id t14mr4017950vch.11.1274233075290; Tue, 
	18 May 2010 18:37:55 -0700 (PDT)
Received: by 10.220.168.131 with HTTP; Tue, 18 May 2010 18:37:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147316>

Hey guys,

Git 1.7.1 is freezing when I push something via http and the hook has
some output. From the client side, I see the hook output prefixed with
"remote: " as expected - and then the process just hangs.

The interesting part is I could work around it by adding a sleep to the hook.

Tested on debian 5.0.4 and git 1.7.1. Couldn't reproduce on a mac.

I started digging in the code to attempt to fix it but it will take me
a while heh, not proficient with C.

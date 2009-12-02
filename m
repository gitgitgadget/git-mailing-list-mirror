From: Sebastian Setzer <sebastianspublicaddress@googlemail.com>
Subject: How do you best store structured data in git repositories?
Date: Wed, 02 Dec 2009 22:08:17 +0100
Organization: privat
Message-ID: <1259788097.3590.29.camel@nord26-amd64>
Reply-To: sebastianspublicaddress@googlemail.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 02 22:03:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFwM1-0003aN-KZ
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 22:03:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251AbZLBVDF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 16:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752473AbZLBVDF
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 16:03:05 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:34531 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402AbZLBVDE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 16:03:04 -0500
Received: by bwz27 with SMTP id 27so600984bwz.21
        for <git@vger.kernel.org>; Wed, 02 Dec 2009 13:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to
         :content-type:organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=N7JlRd9rdYHl/jbajVhzscwO+K1uQpVo+1nyvlWkYeQ=;
        b=TaQNt4KuX6wEJkGrpkpjGVIfGbC6EBibtFJlKQD0kW+1dYuZdkO0+jolEz1XXGF4s9
         fWOnqEKU87ruG/RMBwCK5noJSF5U7WCQD64MQ5ZCZPo3OCIhxuaPSPmrsQHyfR+P4mRK
         kQH6hUxWJyv9fEiJamYrZvjTC/Fn6Xi5HkzzE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=subject:from:reply-to:to:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        b=vTmE+jV+ksr0IBnslCf4a/6MQKcANqcEDroj0ZKteidkQPGBfPH3Vo0NEZHqG2b5Xr
         4pOZaP3D96gWRmhrPKRyLsXGVcI1aJHXxB4J0atm0gEjRhWnDr4D0cHVgQPUNEF1bjcK
         DLq/j+hiTLavtGe5dGUugKJ2R8jrw7am6Ddc8=
Received: by 10.204.32.204 with SMTP id e12mr674482bkd.51.1259787788777;
        Wed, 02 Dec 2009 13:03:08 -0800 (PST)
Received: from ?92.227.92.231? (g227092231.adsl.alicedsl.de [92.227.92.231])
        by mx.google.com with ESMTPS id z15sm1907128fkz.6.2009.12.02.13.03.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Dec 2009 13:03:06 -0800 (PST)
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134398>

Hi,
when you design a file format to store structured data, and you want to
manage these files with git, how do you do this best?

I'd like to hear about best practices, experiences, links to discussions
on this subject, ...

Here are some of my questions:

Do you store everything in a single file and configure git to use
special diff- and merge-tools?
Do you use XML for this purpose?
Do you take care that the contents of your file is as stable as possible
when it's saved or do you let your diff tools cope with issues like
reordering, reassignment of identifiers (for example when identifiers
are offsets in the file), ...?

Do you store one object/record per file (with filename=id, for example
with GUID-s) and hope that git will not mess them up when it merges
them?

Do you store records as directories, with very small files which contain
single attributes (because records can be considered sets of
key-value-pairs and the same applies to directories)? Do you configure
git to do a scalar merge on non-text "attributes" (with special file
extensions)?

When you don't store everything in a single, binary file: Do you use git
hooks to update an index for efficient queries on your structured data?
Do you update the whole index for every change? Or do you use git hashes
to decide which segment of your index needs to be updated?

greetings,
Sebastian

From: "Constantine Plotnikov" <constantine.plotnikov@gmail.com>
Subject: [Q] git rebase -i -p conflicts with squash
Date: Wed, 14 Jan 2009 19:13:45 +0300
Message-ID: <85647ef50901140813r6e62ae53u1dbcd48cc472dbcc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 14 17:15:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN8Oe-00080Z-Hv
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 17:15:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760418AbZANQNs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 11:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758977AbZANQNs
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 11:13:48 -0500
Received: from mail-bw0-f29.google.com ([209.85.218.29]:62886 "EHLO
	mail-bw0-f29.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758611AbZANQNr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 11:13:47 -0500
Received: by bwz10 with SMTP id 10so365697bwz.13
        for <git@vger.kernel.org>; Wed, 14 Jan 2009 08:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=FTrPR35TwvIlQ8mLrMYdLNMyPlpSOXTukdPerAYdKvw=;
        b=VlXMlQCOLDUxnvERY5x9jRsv5ukdFzX9ghIeAhR/0meexm8d9+2KyCAmloWDNqgIfK
         +vt+AcywhYTiRvxK2SWGQN6heMQUYKIpy80BDnqaGEIbWequfQyhXiZhn/bzZZwrFoAp
         EJ0OxN0LdSuHXURhzyhp7UC95WwtcGBqrbl7c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=UDCz2I5lVhDI/ZvyVJqOaOsmbb2cAo3ZEEaVCD90XFjP2k9Lo4YkpI8wm/IUUetTdf
         cU2a8ixTe2cbxi5mRgD9kW438KTSgqdFcIZByDfTxu77PHWzv1EE/1BwF8m98x22mQMx
         W1xCsf8c1OwHZDAGXd/6DyGh6kRuNynsrlGIo=
Received: by 10.181.145.6 with SMTP id x6mr79098bkn.25.1231949625242;
        Wed, 14 Jan 2009 08:13:45 -0800 (PST)
Received: by 10.181.143.16 with HTTP; Wed, 14 Jan 2009 08:13:45 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105652>

If I run git rebase --interactive with --preserve-merges option and
select "squash" for one of the commit, the rebase process fails with
the message "Refusing to squash a merge:
5e775c536654640c173ba71a0af7e84bf8bc618a". However the neither commit
participating in the squash is a merge commit. Even more, there are no
merge commits in the repository at all.

>From my limited understanding of squash operation, it should fail only
if one of squashed commits is a merge commit, but it should be
possible to squash non-merge commits without problem as it looks like
quite safe and local operation (and I might want to preserve merges
that happened after squashed commits). Is it the current behaviour a
bug or a feature?

Constantine

From: Matt Graham <mdg149@gmail.com>
Subject: hook for rebase --continue
Date: Mon, 7 Nov 2011 19:42:32 +0000
Message-ID: <CALts4TQ545L1d1J0EiUjd7x=WBJpjCCv6UsXZOoGQAC29RqC5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 07 20:42:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNV5c-0004B6-4c
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 20:42:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032Ab1KGTmf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 14:42:35 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:36569 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838Ab1KGTme (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 14:42:34 -0500
Received: by ywf7 with SMTP id 7so5618504ywf.19
        for <git@vger.kernel.org>; Mon, 07 Nov 2011 11:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=JMqbHcaMwMZSU36fATuttWkMJQ6qZBAPuPNJPMqp9NI=;
        b=GkjeHpj9OnfgjzxGuoI48Rj97coY5mRtNuuMGJszdr0oGnOSZGfBsbf06q7EOYga8j
         SPBiu12n6JMegldy4z2KkfJlphS45Oii5y0MUrpi24FA3fKNI7LH8RV1a406YW6lvg5j
         hn9ypf+rM14wp3sp891MLTizdDnYmt/ckSkX0=
Received: by 10.236.124.105 with SMTP id w69mr37828093yhh.2.1320694953831;
 Mon, 07 Nov 2011 11:42:33 -0800 (PST)
Received: by 10.147.171.3 with HTTP; Mon, 7 Nov 2011 11:42:32 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185018>

Hi,
I did some testing and it appears that during a rebase, if I resolve a
conflict and call git rebase --continue, the pre-commit hook doesn't
run.  This means that if I don't resolve the conflict correctly, our
check for invalid syntax doesn't get run and creates the risk that
someone could push code with invalid syntax, not realizing that the
check didn't run.

Does anyone else share my expectation that the pre-commit hook should
run during a rebase? Or at least for the first commit following a
rebase conflict?

If not, is there another hook that is triggered by a rebase that I
should be using instead?

Thanks,
Matt

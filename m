From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Gitweb; ordering of fork list on summary page (was Vanilla gitweb vs repo.or.cz)
Date: Wed, 23 Jul 2008 18:10:52 +0100
Message-ID: <e2b179460807231010m44ff446auc054ead9178c711b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Jul 23 19:12:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLhsp-0006e9-6X
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 19:12:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754603AbYGWRKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 13:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754597AbYGWRKz
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 13:10:55 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:48180 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752810AbYGWRKy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 13:10:54 -0400
Received: by wx-out-0506.google.com with SMTP id h29so2309653wxd.4
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 10:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=T0xqenjvr8IxCfAr005lgttWfcZ2EBzjxottirG9yBE=;
        b=Z691xCn/wIWM6pWSAa3XEF0Rw3OF654SYYNa7LazCC4PgjcWPeX0mrrJRXVPKTosmP
         oo0ryfODURHYkQ3IaOTOefhpW86XlHU6zD+CMkdpJrdcrW52XGVgYa0gyij7tAg+fukm
         hMi65EYZ1iTNKMqcbkyv/plPsFI8hrFLYyvx0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=X3jt0f04n3WecnVBrjl7FA2dUECWuOf7ccLBhIYJChuQMdSrdq2OY3W8cC/NwUqxFT
         KIPozzExKTG+mFfFEEyU9F6LMjox4HW7BV2HQSki899+UpPyLSsJJKdTzIl0DJFvZOaT
         EGpXS9F4/SuTgovABVMmSd1K0Oc1oZp9Qq8LY=
Received: by 10.70.19.20 with SMTP id 20mr247932wxs.54.1216833052930;
        Wed, 23 Jul 2008 10:10:52 -0700 (PDT)
Received: by 10.70.110.16 with HTTP; Wed, 23 Jul 2008 10:10:52 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89716>

2008/7/13 Petr Baudis <pasky@suse.cz>:
>  Then, there is the http://repo.or.cz/w/git/gitweb.git repository,
> which was my old attempt at maintaining gitweb actively. Unfortunately,
> this didn't quite work out because of my general lack of time and
> dedication.

Notwithstanding the above, I've pushed a little 'fix' to the mob branch:

http://repo.or.cz/w/git/gitweb.git?a=commitdiff;h=3e8f6e9125071a7e17c88efb69c1780d775025bc

The list of forks on the summary page was unsorted, this just makes
them sorted by age, which seems a fair way to decide which forks are
shown before the list size cut-off (15) kicks in.

s/noheader/no_header was just to make it obvious what the parameter
affects, so all the code can be found with one grep, and s/undef/'age'
just shows the intent, although that parameter isn't what actually
controls the sort order. Or, I guess, the sorting could be refactored
out of the header generation code.

Mike

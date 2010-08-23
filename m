From: Seth Kriticos <seth.kriticos@googlemail.com>
Subject: How does git deal with hard links in source code?
Date: Mon, 23 Aug 2010 10:33:38 +0200
Message-ID: <AANLkTik3858Kf6MSPALeNYrE6L=ixf=0s028+_ie_SW_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 23 10:33:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnSTc-0000nu-3D
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 10:33:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634Ab0HWIdl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 04:33:41 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45668 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128Ab0HWIdj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 04:33:39 -0400
Received: by iwn5 with SMTP id 5so3375805iwn.19
        for <git@vger.kernel.org>; Mon, 23 Aug 2010 01:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=Trrzi9Wp1kCryu/2u+ujrsxqKURCXV6JNGFg5PSnaVs=;
        b=A6Z/6okcte4JQtlZDOlpvKjhmx9tQdH4QADabMDLW8ZaGdofQ2Wge/TeNM5TTOY9ac
         fjdwD6Ple2jbXsZvHqWTqAyr10/WgHah04v/HtNqRx/FzJeQlz0C0UdOoNBwNlfuCGNv
         K+D/fsexdDf8VAj9kP7Cn2CNwATgXM18Q5/bg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=qsz0sZmnt3hYky0HQoQhLfWxY+2w/rRQk5WlpGEBKFwy6nA1co4IIsmvYvczLLNG14
         3NuHdQXotD4qb232WEPl1w7RUh4nT4ZeOIGQYKFpGZLjHYMh3gLYtBM8Msm0tKIXhtK8
         PIPp85cd9pbDOBjzSwIMHUrvQ59OR8kBDV1PY=
Received: by 10.231.17.11 with SMTP id q11mr5157481iba.63.1282552419028; Mon,
 23 Aug 2010 01:33:39 -0700 (PDT)
Received: by 10.231.31.129 with HTTP; Mon, 23 Aug 2010 01:33:38 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154207>

Hi list,

I've got a question my google-fu and the docs were not able
to answer:

Is there a way to preserve the hard links that are within
a git repository checkout (the stuff that is tracked by the
git repository)?

The use-case I have is the following: I want to have two
different template directories for stuff in the tracked
sources: a base one and some extended ones. I want to have
the stuff from the base one hard-linked to the extended one,
so changes in the base one change all the other depending
templates too.

Now for testing I committed and pushed an instance of this
and then cloned the repository, and it ate my hard links
(checked out two separate copies of the files).

Is there a way to convince git not to eat my hard links
without some complicated scripting magic and checkout hooks?

~ Seth Kriticos

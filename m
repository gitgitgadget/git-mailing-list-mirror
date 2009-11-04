From: Patrick Higgins <patrick.allen.higgins@gmail.com>
Subject: How to ensure a word has been removed from repository?
Date: Tue, 3 Nov 2009 19:12:49 -0700
Message-ID: <6fb3af8e0911031812j54a9b698xca9f5301ac07442a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 04 03:13:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5VMp-00019k-UT
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 03:13:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753891AbZKDCMt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 21:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753797AbZKDCMt
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 21:12:49 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:63737 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753666AbZKDCMs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 21:12:48 -0500
Received: by yxe17 with SMTP id 17so5998456yxe.33
        for <git@vger.kernel.org>; Tue, 03 Nov 2009 18:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=qz/T4jhjOpRxmIEopsztZmJLz5jqtVlVYdiagZyJxkQ=;
        b=J7PfgSoHBjVZwm/Mx0boVS6uCKQeXh4SqWnvdnhd1vr5wjIak2GqVJID9a1CuBogoA
         p7l3g0fwtWbzJXRvxi6zQuWp1nxpo59Ps8PgVx/Ujm8efkfAahVhEct5BlgShHpxRX0d
         jGpHMozAHSWCG7jC/M3LsBh7Nj8TfzPcLlFp8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=Dg2kyzUGXgS2bv9XnOZZe0qupXvKmbqHvyw+sOSGHz640hghUa7wzg5JOukRP8UaRQ
         hhXvRz3S8cNzJ0cnWqL4S5seeQuIi7MzNvluWWS86oxD/9xTONX2P4LyRHlpD/5vStqh
         xjiypEdYaPSGjscFYCVUQ1ux3dudS6JSCBgEU=
Received: by 10.100.237.16 with SMTP id k16mr949407anh.128.1257300769477; Tue, 
	03 Nov 2009 18:12:49 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132023>

Hi all,

I just completed a series of filter-branch commands to remove a couple
of sensitive words from a repository before I publish it. The words
were found in commit messages, directory names, file contents, and
various other places (kind of weird, I know). I believe I have removed
them all, but I would like to double check but don't know how.

Given that much of the repository is stored in compressed packs, I
can't just use grep to look for the words. To get around this, I've
unpacked the objects, use a Perl script (filtinf example script) to
decompress them and then use grep (this has proven to be quite slow).

Is that going to find every possible occurrence if all the relevant
files are plain text?

Is there an easier way to search the repository? The way I'm doing it
has required some awfully deep knowledge to expire and prune
everything. I feel like I must be missing something.

Thanks,
Patrick

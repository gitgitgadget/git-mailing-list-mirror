From: shawn wilson <ag4ve.us@gmail.com>
Subject: filter / gitattributes
Date: Tue, 24 Jun 2014 15:02:30 -0400
Message-ID: <CAH_OBiesJe2shQ3KWQa54-uoCOeWVQXe5voihJJH5_TiTqF4zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 24 21:03:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzVzb-00014q-KW
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jun 2014 21:02:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753372AbaFXTCw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2014 15:02:52 -0400
Received: from mail-ve0-f173.google.com ([209.85.128.173]:50732 "EHLO
	mail-ve0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753302AbaFXTCv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2014 15:02:51 -0400
Received: by mail-ve0-f173.google.com with SMTP id db11so830122veb.32
        for <git@vger.kernel.org>; Tue, 24 Jun 2014 12:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=4K9HXI4sqNtpSov0aRZ8lgyX39ZPl5+QEDe0NjqXc0I=;
        b=BDDWzeTE6oqeFaiH/p/akUpeVNwJRjQt4I07NhHH9uBA17G/biPLWJRpeoRcsLoDJY
         g2ka350PpkqeNAd0DBS+tzpmnGGFmU67RnvS97TLJ1mhcXF7Krf+9hCEBsIp3UEliMDD
         TPwA7Morv9QAkFVh28mU8QJQLDZyMJJIHDtcZrTMBUgTx3Bbhp5rhDRJYhiyYTJIW52o
         ZoZXISX7D0SbuL10QuJ5g9lx05K+2SNCh87x/fgHZxwfAKGOO7OmzPxGo9tu/tmcOyC0
         omp+Zg8fnK0wvQErI2PB+gBQcp2TMTZ3nLBSOb/8eK/tHLvdMnAeEJaMvu4O/RMof5kB
         CM7g==
X-Received: by 10.220.68.83 with SMTP id u19mr2008475vci.52.1403636570341;
 Tue, 24 Jun 2014 12:02:50 -0700 (PDT)
Received: by 10.52.92.46 with HTTP; Tue, 24 Jun 2014 12:02:30 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252419>

So, I've got a gitconfig template for new people (also what link to as
my ~/.gitconfig) so I have a smudge/clean:

[filter "gitconfig-rmuser"]
  clean = sed -e \"s/^\\( *email =\\).*/\\1 <email address>/\" -e
\"s/^\\( *name =\\).*/\\1 <real name>/\" -e \"s/^\\( *signingkey
=\\).*/\\1 <gpg key>/\"
  smudge = egrep \"^ *(email|name|signingkey) = \"

and .gitattributes:
* filter=ident-line
gitconfig filter=gitconfig-rmuser

However, it didn't filter/change my name/email/signingkey. Any ideas?

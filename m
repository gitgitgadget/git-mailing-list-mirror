From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: weaning distributions off tarballs: extended verification of git tags
Date: Tue, 3 Mar 2015 06:20:26 +0700
Message-ID: <CACsJy8C3=f=esBrHE8OudSa0nUbCrLaYJtLC2in3p+tcc-d9bw@mail.gmail.com>
References: <1425134885.3150003.233627665.2E48E28B@webmail.messagingengine.com>
 <CANv4PNmF9sTh8od9xT5tYTOF1Cv0Mev2Muf-qxQDS_6kE7EnOw@mail.gmail.com>
 <1425316197.895196.234425829.536E6C06@webmail.messagingengine.com> <20150302181230.GA31798@kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing List <git@vger.kernel.org>
To: Joey Hess <id@joeyh.name>
X-From: git-owner@vger.kernel.org Tue Mar 03 00:21:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSZe1-00006Q-SQ
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 00:21:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754064AbbCBXU5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 18:20:57 -0500
Received: from mail-ig0-f170.google.com ([209.85.213.170]:42819 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753944AbbCBXU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2015 18:20:57 -0500
Received: by igkb16 with SMTP id b16so21961838igk.1
        for <git@vger.kernel.org>; Mon, 02 Mar 2015 15:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Xy9FTZ4AJb994o6y59jTxd8QPZl88IKXNg85TUu5lLM=;
        b=S/4PJYcO/euiDOu/jZ8Ln0phEyDES0NplnuAl4fjTu6hdCLR633UxcGG3Ztn1V9bkj
         EewGbt3kdXRySXZOgdiiHYym+KWQHHI5l6cqavdYSmXKeAndsGV4DOQ3aNUXjDahYJJ6
         E1pv9NPe5JAvcAozjzm97FGBemxEcVPWKi6F5kOov+8RfUKncCdEMI1CZHcqTW6LNaS5
         5+KapMiAt/PD2IAESPBWbD5VdNg3gaIeynzaqbFqtQ3iwZceyFj5rwQI7r5KeNfQpH3H
         5QBwDONliQMzQez0WEBOUZD9IedmWSHsNW8FCLwb2mpJtLndutwggcqNlywwb5CsA+H0
         6b8g==
X-Received: by 10.50.78.131 with SMTP id b3mr24555858igx.0.1425338456523; Mon,
 02 Mar 2015 15:20:56 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Mon, 2 Mar 2015 15:20:26 -0800 (PST)
In-Reply-To: <20150302181230.GA31798@kitenet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264634>

On Tue, Mar 3, 2015 at 1:12 AM, Joey Hess <id@joeyh.name> wrote:
> I support this proposal, as someone who no longer releases tarballs
> of my software, when I can possibly avoid it. I have worried about
> signed tags / commits only being a SHA1 break away from useless.
>
> As to the implementation, checksumming the collection of raw objects is
> certainly superior to tar. Colin had suggested sorting the objects by
> checksum, but I don't think that is necessary. Just stream the commit
> object, then its tree object, followed by the content of each object
> listed in the tree, recursing into subtrees as necessary. That will be a
> stable stream for a given commit, or tree.

It could be simplified a bit by using ls-tree -r (so you basically
have a single big tree). Then hash commit, ls-tree -r output and all
blobs pointed by ls-tree in listed order.
-- 
Duy

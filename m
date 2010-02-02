From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: How can I create a commit without a parent?
Date: Tue, 2 Feb 2010 11:40:53 -0500
Message-ID: <76718491002020840y16d62fb5qc4f6c51602dac94f@mail.gmail.com>
References: <ron1-5383E3.00002602022010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 17:49:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcLwG-0000yv-Se
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 17:49:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756652Ab0BBQtM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Feb 2010 11:49:12 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:48121 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756295Ab0BBQtJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Feb 2010 11:49:09 -0500
Received: by iwn39 with SMTP id 39so296104iwn.1
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 08:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FJ2NSieHR/OKafH9L7JxTUz7nobBaxS7lRQFOpxh6sg=;
        b=R6UJXqErZh0225lE1IRt0BIA5rRNAymv798JGBF6Ig6b4W+rQFz+ZIhy5nHtbxh6xb
         U4VcPu9b8Q6O96nP99KyK6rLVPWPRfwSG7XuIgI+YRYAgBm2+7w8vdBoQB3Wp7MV9QL5
         fOg8CyCwt1YGb7ctN9CvCIXR+2y8TZgyV/0ho=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RSujPcvxIKJRBt2a4C73GZLyOAsIE1YWHNIt8FLyfaCC0XyuZS3+mAcamHzETnLWeQ
         7exfBu/9mRhOuOthYxYh4AzJ+2TtgoXVxxM5di8ybYSS1x/3+HLFSwXDZ6n74wyPKokE
         uN38b7OG6YejnsiGxi9BrOXn7Vb4RIOmjuMRM=
Received: by 10.231.158.205 with SMTP id g13mr2486120ibx.30.1265128854024; 
	Tue, 02 Feb 2010 08:40:54 -0800 (PST)
In-Reply-To: <ron1-5383E3.00002602022010@news.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138730>

On Tue, Feb 2, 2010 at 3:00 AM, Ron Garret <ron1@flownet.com> wrote:
> SLSIA. =C2=A0git commit-tree insists on having at least one parent co=
mmit at
> the command line. =C2=A0From reverse-engineering it seems like I coul=
d do it
> by setting .git/HEAD to 'ref: refs/heads/some-nonexistent-branch' but
> mucking with HEAD directly like that feels kinda scary.

I guess you're looking to do it with plumbing, but with porcelain the
way I'd do it is:

$ git init foo
$ git init bar
$ cd bar
$ git commit --allow-empty -m "empty bar root commit"
$ cd ../foo
$ git commit --allow-empty -m "empty foo root commit"
$ git fetch ../bar master:bar

j.

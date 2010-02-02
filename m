From: Aneurin Price <aneurin.price@gmail.com>
Subject: Git and Amazon S3
Date: Tue, 2 Feb 2010 13:56:41 +0000
Message-ID: <501db8661002020556k2f65add2rf06b289f2c9cbcac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 02 14:56:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcJFI-00011Z-I5
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 14:56:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756018Ab0BBN4n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 08:56:43 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:63113 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755943Ab0BBN4n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 08:56:43 -0500
Received: by ewy28 with SMTP id 28so84785ewy.28
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 05:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=IjG4eSW/9R1jPqCPeccKqCGFci8xbOCjVfSloKNT+5I=;
        b=FF6axsrvWMOX4xokn5+w6IWVnES11c+iACyvtmUL+AuHjI9at1xzIr/uMK6D8JrKSv
         0qIUiDP9lXiSTrjKFGHoFcxyJb8Vq0bj9pOnvKuXymNc3nNmsLsDJghoy9bByu4Im9Yn
         RLC16qtniqkOAX8GgYC1NCMHDHVEe1r8HARDo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=s3paTpWDT7ylLizVTFMApWZAGD9Wkfzm875jMStU11jK/XsBdm0Ia5Vh1Eytnq6dzA
         6l52dVH78Yp9fw/O96dsQePvkz6oDhmfx6IYCjZtMBDibVKeXqXmGsyriI0IRFRi1k6f
         d9ZWAip3sB1IsJOmSPhO0VfrhNiD8AsJ4zdjg=
Received: by 10.216.88.212 with SMTP id a62mr3617333wef.72.1265119001541; Tue, 
	02 Feb 2010 05:56:41 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138717>

Hello all,

I have several (mostly private) git repositories which I'm using for various
purposes including versioned backup of moderate amounts of data, and I'm trying
to work out the cheapest way of having them remotely backed-up. Since I'm not
doing collaborative development, the git hosting options I've found aren't a
good fit - for this amount of data they tend to assume you must have a huge
project with many contributors, and charge accordingly.

It looks like the cheapest option from a pure storage and data-transfer point of
view would be S3, so I'm looking at the best way to use it with git. So far, the
options I've found are either using jgit, which I've never used but appears to
have a native S3 transport, or using one of the FUSE options to mount S3 as a
filesystem.

I'm not particularly happy about the idea of using jgit since it would require
java on all the machines I might want to use it with, and it would mean learning
to use a different command for fetch and push. It does have the bonus that it's
possible to publish repositories for read access via dumb http though. On the
other hand, I'm concerned about the fuse option because a) I'm not sure how
reliable it is, and b) I'm concerned that the abstraction might leak if, for
example, git assumes that it is accessing a local filesystem and acts
differently.

Does anyone have any remarks about these options? Is there a better option - how
difficult would it be to add native support to git? Are there any other options
for more git-friendly remote storage at a comparable price? Or maybe I should
just give up, spend more and get a Linode; then I'd have the flexibility to do
whatever I want with it.

Thanks for your time,
Aneurin Price

From: "Han-Wen Nienhuys" <hanwenn@gmail.com>
Subject: Re: git branch performance problem?
Date: Wed, 10 Oct 2007 18:24:57 -0300
Message-ID: <f329bf540710101424q22309489sada99907e94b2cd0@mail.gmail.com>
References: <f329bf540710101322xdea6210x5576779f2efd89b7@mail.gmail.com>
	 <8c5c35580710101344t3aed4214h4f999072483c4cb5@mail.gmail.com>
	 <f329bf540710101417w640b2421v73279cc8e34449b8@mail.gmail.com>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 10 23:25:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ifj3F-00085j-Gi
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 23:25:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756602AbXJJVZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 17:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756546AbXJJVZA
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 17:25:00 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:21733 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbXJJVY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 17:24:59 -0400
Received: by py-out-1112.google.com with SMTP id u77so631902pyb
        for <git@vger.kernel.org>; Wed, 10 Oct 2007 14:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=yFf89iS3eWfMaRpKDQlzBivVBrLjL0B9kzptqBMyPhk=;
        b=sAo/5hYRAT/fcgtHKKeowZFo832NCIvZamZsb6d8QjjKdlaJgGhB4IlV+bMnOEf1tVM8TfzD2RNOyV87cavV02fOlHdqqsfIvsqYy07hX94lKTKy0cJc4kyyofUhjew9uLlcYyZ6598aPkLr5BQr2TVQjc2nCpK/+yaSUeFLWEM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VIp25x8OoPsdt/xAnY3TcA+SgFQ8MnKSIQo0cPnhaXMnSyOzVfrtlRcGG78ULfSUA9eX34UFVLE+jlaIoj8HnwlBtrP/2qPqvSb6a8wrZpQgD8+b3gUPHKtlGdavoC7zC81MXXh2ARQFk65dlZ4rFY4hViKhpEmZN1JtUBLQ1JQ=
Received: by 10.65.95.12 with SMTP id x12mr2459026qbl.1192051497918;
        Wed, 10 Oct 2007 14:24:57 -0700 (PDT)
Received: by 10.65.157.11 with HTTP; Wed, 10 Oct 2007 14:24:57 -0700 (PDT)
In-Reply-To: <f329bf540710101417w640b2421v73279cc8e34449b8@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60545>

2007/10/10, Han-Wen Nienhuys <hanwenn@gmail.com>:
> > You probably want to run 'git gc' (which will run 'git pack-refs',
> > i.e. put all files currently under .git/refs into a single file). This
> > should speed up 'git branch' (and quite possibly other commands too).
>
> This seems rather unuseful. After running gc pack-refs --all, I lost my HEAD,
>
> hanwen@lilypond:~/vc/git5$ git show HEAD
> fatal: ambiguous argument 'HEAD': unknown revision or path not in the
> working tree.

More to the point, I seemed to have lost my entire repository. This is
the type of surprise  I don't enjoy.

Now, can someone explain why 'git branch' takes forever if there are
only two non-remote branches ?

-- 
Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen

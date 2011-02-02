From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Tracking empty directories
Date: Wed, 2 Feb 2011 10:54:49 +0700
Message-ID: <AANLkTikkymYmnXh7XB1SM8br_oK-YmAJYfkwjTuLzr+f@mail.gmail.com>
References: <AANLkTi=gf9_618iojpYJgN_msAe-FBq-Jao=sj76VQak@mail.gmail.com>
 <AANLkTi=u6=mhOd9LFYRy48y41xRcXmYDtktOKoBjjMgO@mail.gmail.com>
 <20110201183508.GE3771@burratino> <201102012003.50941.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Dmitry S. Kravtsov" <idkravitz@gmail.com>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 02 04:55:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkToj-0003Sb-3K
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 04:55:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753446Ab1BBDzW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Feb 2011 22:55:22 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55446 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752799Ab1BBDzV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Feb 2011 22:55:21 -0500
Received: by wyb28 with SMTP id 28so7459879wyb.19
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 19:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=ck4SrfFnXMwIGfiYlU5lg6RfUEsRtba6vmRs2I8Ms7Y=;
        b=BbVxkh+lzxaQonlvtA2G95EXV0vaXpbwWc5wS0lYgoESmb6LhEDKop39sTV2opw0qS
         9HL0hdH4lvOdXH+XQAQ38BDJC0fHPoDSYhUBU+ncQeeUzeDd1UZbrOmsT78pSrJCws8z
         1cz7BSDfiBiNPZkZ6GjED7VPoN2qQDYQfYEsM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=VJVzlCuneP5vEc4AYfqgwXFp28se5Y+9jKEJSnpDyf/rHjJIniiujFdls/RGmsvpo7
         dvXp3PdgGy88krP5J/dLthzlOSCBwmFVBlzI+QHESTrQXuYVnbR5WxfJZfsltXPnCylC
         AnKGnqr+hjADp1ZLms0QvL7rsDNPI8u9/iPcM=
Received: by 10.216.59.143 with SMTP id s15mr1419800wec.49.1296618919759; Tue,
 01 Feb 2011 19:55:19 -0800 (PST)
Received: by 10.216.63.14 with HTTP; Tue, 1 Feb 2011 19:54:49 -0800 (PST)
In-Reply-To: <201102012003.50941.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165892>

On Wed, Feb 2, 2011 at 2:03 AM, Jakub Narebski <jnareb@gmail.com> wrote=
:
>> To add, one would use "git update-index --add".
>
> Porcelain version could be "git add -N <directory>", don't you agree?

"git add" is recursive, with or without -N. What I worry is user
accidentally "git add -N <dir>" where <dir> is not empty, which adds
everything in <dir>.

>> The magic disappears when you register a file within that directory;
>> to tell git you want to keep it, one would mkdir and
>> "git update-index --add" again. =C2=A0Once it's working, we can thin=
k about
>> if there is a need for making that last step automatic after all
>> (my guess: "no"). ;-)
>
> Hmmm... could we use mechanism similar to assume-unchanged to mark
> directory as explicitely tracked, and that git should not remove it
> when it becomes empty?

I think git-attr suits better, more persistent. Although if you insist
the directory must stay, why not just put a hidden file in there?
--=20
Duy

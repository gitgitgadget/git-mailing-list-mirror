From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2009, #01; Wed, 07)
Date: Wed, 28 Oct 2009 15:08:11 -0700
Message-ID: <fabb9a1e0910281508m3e9bb8a6g7b39abc29fceae78@mail.gmail.com>
References: <7viqeqjsx6.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0910080848380.4985@pacific.mpi-cbg.de> 
	<fabb9a1e0910072349q68d6756cgebb041a0bbe2ba65@mail.gmail.com> 
	<20091008173900.GI9261@spearce.org> <fabb9a1e0910081058m59527600o392a6b438b18512e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, vcs-fast-import-devs@lists.launchpad.net
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 28 23:08:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3Gh4-00083l-BV
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 23:08:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752977AbZJ1WI2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 18:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752705AbZJ1WI1
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 18:08:27 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:40381 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495AbZJ1WI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 18:08:27 -0400
Received: by ewy4 with SMTP id 4so1245672ewy.37
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 15:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=bOZmuzKCYmWmdq2v8CX2OJDxVpyq6ZwlA3h2l2nK3MA=;
        b=r627udIEnNC6TV64Q0BU29VNDop5+SFWLA1VGU6Bl1n9v0ij1hve2fgEcXGZS5gBfB
         BvsKhXIYyv37DCri6v3FDfjjkyTwCV5zlvHUwLHw+9/Qfw878eX9CQjqmE5ITfuSNYQV
         INmt4SnbTOZVADxA+KwisXFkxpeggOjA9ZFXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=lcC+l85XTUUZlNIrV7+4Lx/B2+EYXyv4UHsqvoA+bK/eX6vezOHuvKln9PLHuuPMc2
         zANtuhe8ZkwiDtNkzXCWVbEkfgDemTVkvh4cQucXmHONx3Uakoh5druPxhUgN0IwyBGO
         LSHUzpSnoYei+g+lSCzw6NNyWAwsITSVLl3yM=
Received: by 10.216.87.11 with SMTP id x11mr1311902wee.16.1256767711128; Wed, 
	28 Oct 2009 15:08:31 -0700 (PDT)
In-Reply-To: <fabb9a1e0910081058m59527600o392a6b438b18512e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131500>

Heya,

On Thu, Oct 8, 2009 at 10:58, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> I think it makes to ignore options that are not for our vcs, as long
> as options that change import behavior (such as marks, date-format)
> are combined with, say, 'feature tool=git'. This way we can be sure
> that when outputting out a vcs specific stream, it is only parsed by
> that vcs.
>
> Note: yes, I know that marks and date-format are features now, but
> there's really no other suitable example that I could think of).
>
> vcs fast import devs please ack this idea (and perhaps suggest
> something other than "feature tool=git" if preferable) so that I can
> reroll my gfi-options series :).

Shawn, what do you want to do with this, it seems the vcs devs are not
very interested in this feature, should I implement it as described
above? That is:
  * If you use any option that is stream-changing you should include
"feature tool=git" in your stream
  * import-marks and export-marks are made into features
  * "option vcs" is ignored if vcs is a different vcs
  * "option vcs" must be recognised if vcs is this vcs

-- 
Cheers,

Sverre Rabbelier

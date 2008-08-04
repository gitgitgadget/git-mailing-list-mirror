From: "Ray Chuan" <rctay89@gmail.com>
Subject: [git/perl] unusual syntax?
Date: Mon, 4 Aug 2008 12:49:27 +0800
Message-ID: <be6fef0d0808032149p651309a8o773dca5f16923ee1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 04 06:50:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPs1i-0001a7-70
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 06:50:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbYHDEta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 00:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbYHDEta
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 00:49:30 -0400
Received: from ti-out-0910.google.com ([209.85.142.190]:8466 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321AbYHDEt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 00:49:29 -0400
Received: by ti-out-0910.google.com with SMTP id b6so464591tic.23
        for <git@vger.kernel.org>; Sun, 03 Aug 2008 21:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=q/xKKIeHptN6Y5r3gi/5itR2oilOk9ocNFmfHBm7m/o=;
        b=EFjbaY7GL1+G9jWsED+QOutjAO5/IC6kfTOEcy5CB7Rac/gRk7JCUvNXGjuvQFHrBz
         mDBnLTf5qEFNjO2r+0OIFznpKrVaHCUQNhobxYBQk+Tu47XA0jo3imc6CvlkyBe0YbdS
         /hRKu9Q4IhFMDmtf6XB/6BdWcwLk2nWs4SMlE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=fx7WYivjlmuoNGgR+3cIx7vTNk6I+l723laZSyvkSL+OLjywokijXRarVwQnS4lLtQ
         cChyu7z2v2LSOdyD9yFYJmsvXWfPZuSpMXmIW3w20uvRioLrECZXJTstZGKYWXcES8au
         bITqMUcTeNe8So8qTnGKSM0KFAIpF/HGD38T8=
Received: by 10.110.15.9 with SMTP id 9mr9057442tio.44.1217825368108;
        Sun, 03 Aug 2008 21:49:28 -0700 (PDT)
Received: by 10.110.37.4 with HTTP; Sun, 3 Aug 2008 21:49:27 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91314>

Hi,

i noticed that this doesn't work for me (Perl 5.10):

sub _close_hash_and_insert_object {
	my ($self) = @_;

	return unless defined($self->{hash_object_pid});

	my @vars = map { 'hash_object_' . $_ } qw(pid in out ctx);

	command_close_bidi_pipe($self->{@vars});
	delete $self->{@vars};
}


$self->{@vars} evaluates to undef. i can't find any mention of using
arrays to dereference objects in the manual and elsewhere; is this a
mistake?

-- 
Cheers,
Ray Chuan

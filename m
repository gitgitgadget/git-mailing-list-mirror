From: "Jacob Helwig" <jacob.helwig@gmail.com>
Subject: Re: 'mail' link on http://repo.or.cz/w/git.git no workee?
Date: Thu, 15 Jan 2009 18:32:56 -0800
Message-ID: <8c9a060901151832l71464185qf9f88afede6f550d@mail.gmail.com>
References: <alpine.DEB.1.00.0901151651460.3586@pacific.mpi-cbg.de>
	 <20090116015439.GF12275@machine.or.cz>
	 <7vmydsovs5.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0901160315170.3586@pacific.mpi-cbg.de>
	 <20090116022408.GG12275@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Jan 16 03:34:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNeXP-0005Jy-MW
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 03:34:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760818AbZAPCc7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 21:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759740AbZAPCc7
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 21:32:59 -0500
Received: from qw-out-2122.google.com ([74.125.92.26]:51296 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758068AbZAPCc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 21:32:58 -0500
Received: by qw-out-2122.google.com with SMTP id 3so585331qwe.37
        for <git@vger.kernel.org>; Thu, 15 Jan 2009 18:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=99yc4ZQen5egDXPXUi2RruEUtBmT4gHs3jkRqKYW92k=;
        b=McMd1w42RM6eSl2PFrOapg3H9euPy+F9/D8D6Ohn58Q8e2Ojxu56h6kD+k+TkY1rQU
         hLxiB9275dhWwxu2BQz6qRxlexAXsFcy23GJaJBHdeUO49y64xGTixjLPNPKeJIc/WJn
         ngRyvS775PtdqtFRe8H+ZVFqdrMyIpo8M/l8k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ciGNQwaTIg2b4GMMFMRhE0KuT3/s9Lb12oKXyZrL+XmVEGIcWktI2OsA4PEfRE9e9c
         HjhAqP2h8SUMhSmxOUa0dC24IL38QEGm64XEuiMhJlxW+/tXfE7o/5hUcQOKNuUvRW88
         3W1w+4+V8XJDdrCpe4M/mZA7r0U5XJxT+s5vw=
Received: by 10.215.38.17 with SMTP id q17mr2918217qaj.32.1232073176810;
        Thu, 15 Jan 2009 18:32:56 -0800 (PST)
Received: by 10.214.243.1 with HTTP; Thu, 15 Jan 2009 18:32:56 -0800 (PST)
In-Reply-To: <20090116022408.GG12275@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105911>

On Thu, Jan 15, 2009 at 18:24, Petr Baudis <pasky@suse.cz> wrote:
>
> IIRC I found no way to actually make a gmane link since it requires POST
> query for the searches or something.
>

$ cat bin/gmane-links.pl
#!/usr/bin/perl

use strict;
use warnings;

use Mail::Summary::Tools::ArchiveLink::Gmane;

unless ($ARGV[0]) {
    print STDERR "Must provide a message-id.\n";
    exit 1;
}

my $link = Mail::Summary::Tools::ArchiveLink::Gmane->new(message_id =>
$ARGV[0]);

print "Thread: " . $link->thread_uri() . "\n";
print "Message: " . $link->message_uri() . "\n";

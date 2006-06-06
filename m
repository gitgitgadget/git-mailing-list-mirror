From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-format-patch: add --output-directory long option
 again
Date: Tue, 6 Jun 2006 16:53:25 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606061650360.2063@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060606141946.G59b8a1fd@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 06 16:54:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fncvy-0004uO-U7
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 16:53:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbWFFOx2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 10:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbWFFOx2
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 10:53:28 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:56007 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932194AbWFFOx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jun 2006 10:53:27 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 29B1623B6;
	Tue,  6 Jun 2006 16:53:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 1D0982393;
	Tue,  6 Jun 2006 16:53:26 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id E2F201CE9;
	Tue,  6 Jun 2006 16:53:25 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Dennis Stosberg <dennis@stosberg.net>
In-Reply-To: <20060606141946.G59b8a1fd@leonov.stosberg.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21378>

Hi,

what idiot wrote that part of the code originally? ;-)

On Tue, 6 Jun 2006, Dennis Stosberg wrote:

> @@ -243,6 +241,12 @@ int cmd_format_patch(int argc, const cha
>  	if (argc > 1)
>  		die ("unrecognized argument: %s", argv[1]);
>  
> +	if (output_directory && !stdout) {
> +		if (mkdir(output_directory, 0777) < 0 && errno != EEXIST)
> +			die("Could not create directory %s",
> +			    output_directory);
> +	}
> +
>  	if (rev.pending_objects && rev.pending_objects->next == NULL) {
>  		rev.pending_objects->item->flags |= UNINTERESTING;
>  		add_head(&rev);

Would it not be better to

	if (output_directory && stdout)
		die("What do you want: stdout or a directory?");

Ciao,
Dscho

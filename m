From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC PATCH v2 10/16] Git-aware CGI to provide dumb HTTP transport
Date: Tue, 13 Oct 2009 12:56:13 +0200
Message-ID: <4AD45CCD.1000509@viscovery.net>
References: <1255400715-10508-1-git-send-email-spearce@spearce.org> <1255400715-10508-11-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 13 12:59:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxf6I-0006Yk-Id
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 12:59:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754697AbZJMK4v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 06:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754418AbZJMK4v
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 06:56:51 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:48846 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753083AbZJMK4u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 06:56:50 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Mxf37-0005Lu-BD; Tue, 13 Oct 2009 12:56:13 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 27A879614; Tue, 13 Oct 2009 12:56:13 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1255400715-10508-11-git-send-email-spearce@spearce.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130157>

Shawn O. Pearce schrieb:
> +int main(int argc, char **argv)
> +{
> +	char *dir = getenv("PATH_TRANSLATED");
> +	char *input_method = getenv("REQUEST_METHOD");
> +	struct service_cmd *cmd = NULL;
> +	char *cmd_arg = NULL;
> +	int i;
> +

Please insert here:

	git_extract_argv0_path(argv[0]);

> +	set_die_routine(die_webcgi);
> ...

-- Hannes
